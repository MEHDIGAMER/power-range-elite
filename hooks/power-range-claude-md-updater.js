#!/usr/bin/env node

/**
 * Power-Range Auto CLAUDE.md Updater
 *
 * Runs at session close (called by power-range Step 20).
 * Reads MISTAKES.md for new entries, extracts prevention rules,
 * and appends them to the project's CLAUDE.md.
 *
 * Cap: 150 lines max. Oldest auto-generated rules rotate out.
 */

const fs = require('fs');
const path = require('path');

const MAX_CLAUDE_MD_LINES = 150;
const AUTO_SECTION_MARKER = '## Auto-Learned Rules (Power-Range)';
const MAX_AUTO_RULES = 20;

function findProjectRoot() {
  let dir = process.cwd();
  while (dir !== path.parse(dir).root) {
    if (fs.existsSync(path.join(dir, 'package.json')) ||
        fs.existsSync(path.join(dir, '.git')) ||
        fs.existsSync(path.join(dir, 'CLAUDE.md'))) {
      return dir;
    }
    dir = path.dirname(dir);
  }
  return process.cwd();
}

function readMistakes(projectRoot) {
  const mistakesPath = path.join(projectRoot, 'MISTAKES.md');
  if (!fs.existsSync(mistakesPath)) return [];

  const content = fs.readFileSync(mistakesPath, 'utf8');
  const lines = content.split('\n');

  // Extract entries — each mistake starts with "##" or "###" or "- "
  const mistakes = [];
  let current = null;

  for (const line of lines) {
    if (line.startsWith('## ') || line.startsWith('### ')) {
      if (current) mistakes.push(current);
      current = { title: line.replace(/^#+\s*/, ''), lines: [], date: '' };
    } else if (current) {
      current.lines.push(line);
      // Try to extract date
      const dateMatch = line.match(/\d{4}-\d{2}-\d{2}/);
      if (dateMatch) current.date = dateMatch[0];
    }
  }
  if (current) mistakes.push(current);

  return mistakes;
}

function readScorecard(projectRoot) {
  const sessionDir = path.join(projectRoot, '.power-range', 'session');
  if (!fs.existsSync(sessionDir)) return null;

  // Find the latest scorecard or goals file
  const files = fs.readdirSync(sessionDir).sort().reverse();
  for (const file of files) {
    if (file.includes('goals') || file.includes('tester') || file.includes('tech-lead')) {
      const content = fs.readFileSync(path.join(sessionDir, file), 'utf8');
      return content;
    }
  }
  return null;
}

function extractRules(mistakes) {
  const rules = [];

  for (const mistake of mistakes) {
    const body = mistake.lines.join(' ').toLowerCase();

    // Extract actionable prevention rules
    let rule = null;

    // Look for "prevention", "fix", "cause", "never", "always" patterns
    for (const line of mistake.lines) {
      const lower = line.toLowerCase().trim();
      if (lower.startsWith('prevention:') || lower.startsWith('fix:') ||
          lower.startsWith('rule:') || lower.startsWith('never ') ||
          lower.startsWith('always ') || lower.startsWith('- never') ||
          lower.startsWith('- always')) {
        rule = line.trim().replace(/^(prevention|fix|rule):\s*/i, '');
        break;
      }
    }

    // If no explicit rule found, generate one from the title
    if (!rule && mistake.title) {
      rule = `Avoid: ${mistake.title}`;
    }

    if (rule) {
      rules.push({
        rule: rule.startsWith('- ') ? rule : `- ${rule}`,
        date: mistake.date || new Date().toISOString().split('T')[0],
        source: mistake.title
      });
    }
  }

  return rules;
}

function updateClaudeMd(projectRoot, newRules) {
  const claudeMdPath = path.join(projectRoot, 'CLAUDE.md');

  if (!fs.existsSync(claudeMdPath)) {
    console.log('No CLAUDE.md found — skipping auto-update');
    return;
  }

  let content = fs.readFileSync(claudeMdPath, 'utf8');
  const lines = content.split('\n');

  // Find or create the auto-learned section
  const markerIndex = lines.findIndex(l => l.includes(AUTO_SECTION_MARKER));

  let beforeSection, existingRules, afterSection;

  if (markerIndex >= 0) {
    beforeSection = lines.slice(0, markerIndex);

    // Find end of auto section (next ## heading or end of file)
    let endIndex = lines.length;
    for (let i = markerIndex + 1; i < lines.length; i++) {
      if (lines[i].startsWith('## ') && !lines[i].includes('Auto-Learned')) {
        endIndex = i;
        break;
      }
    }

    existingRules = lines.slice(markerIndex + 1, endIndex)
      .filter(l => l.trim().startsWith('- '));
    afterSection = lines.slice(endIndex);
  } else {
    beforeSection = lines;
    existingRules = [];
    afterSection = [];
  }

  // Merge new rules (deduplicate by checking if rule text already exists)
  const allRules = [...existingRules];
  for (const nr of newRules) {
    const ruleText = nr.rule.toLowerCase().trim();
    const isDuplicate = allRules.some(existing =>
      existing.toLowerCase().trim() === ruleText ||
      existing.toLowerCase().includes(ruleText.replace(/^- /, ''))
    );
    if (!isDuplicate) {
      allRules.push(nr.rule);
    }
  }

  // Cap at MAX_AUTO_RULES — remove oldest (first in list) if over
  const cappedRules = allRules.slice(-MAX_AUTO_RULES);

  // Check total line count
  const newContent = [
    ...beforeSection,
    '',
    AUTO_SECTION_MARKER,
    ...cappedRules,
    '',
    ...afterSection
  ].join('\n');

  const totalLines = newContent.split('\n').length;

  if (totalLines > MAX_CLAUDE_MD_LINES) {
    // Trim auto rules further to fit
    const overage = totalLines - MAX_CLAUDE_MD_LINES;
    const trimmedRules = cappedRules.slice(overage);

    const trimmedContent = [
      ...beforeSection,
      '',
      AUTO_SECTION_MARKER,
      ...trimmedRules,
      '',
      ...afterSection
    ].join('\n');

    fs.writeFileSync(claudeMdPath, trimmedContent);
    console.log(`CLAUDE.md updated: ${trimmedRules.length} auto-rules (trimmed ${overage} to fit 150-line cap)`);
  } else {
    fs.writeFileSync(claudeMdPath, newContent);
    console.log(`CLAUDE.md updated: ${cappedRules.length} auto-rules`);
  }
}

// Main
function main() {
  const projectRoot = findProjectRoot();

  const mistakes = readMistakes(projectRoot);
  if (mistakes.length === 0) {
    console.log('No mistakes found — CLAUDE.md unchanged');
    return;
  }

  const rules = extractRules(mistakes);
  if (rules.length === 0) {
    console.log('No actionable rules extracted — CLAUDE.md unchanged');
    return;
  }

  console.log(`Extracted ${rules.length} rules from ${mistakes.length} mistakes`);
  updateClaudeMd(projectRoot, rules);
}

main();
