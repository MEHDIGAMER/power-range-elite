#!/bin/bash
# ============================================================
#  POWER-RANGE ELITE — Integrity Verification
#  Verifies no files have been tampered with after install
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo ""
echo -e "${CYAN}POWER-RANGE ELITE — Integrity Check${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECKSUM_FILE="$SCRIPT_DIR/checksums.sha256"

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo -e "${RED}ERROR: checksums.sha256 not found!${NC}"
    echo -e "${RED}Cannot verify integrity without checksum file.${NC}"
    exit 1
fi

echo -e "${WHITE}Verifying file checksums...${NC}"
echo ""

cd "$SCRIPT_DIR"
FAILED=0
PASSED=0
TOTAL=0

while IFS= read -r line; do
    hash=$(echo "$line" | awk '{print $1}')
    file=$(echo "$line" | awk '{print $2}' | sed 's/^\*//')
    TOTAL=$((TOTAL + 1))

    if [ ! -f "$file" ]; then
        echo -e "  ${RED}MISSING${NC}  $file"
        FAILED=$((FAILED + 1))
        continue
    fi

    actual_hash=$(sha256sum "$file" | awk '{print $1}')

    if [ "$hash" = "$actual_hash" ]; then
        echo -e "  ${GREEN}OK${NC}      $file"
        PASSED=$((PASSED + 1))
    else
        echo -e "  ${RED}TAMPERED${NC} $file"
        echo -e "           Expected: $hash"
        echo -e "           Got:      $actual_hash"
        FAILED=$((FAILED + 1))
    fi
done < "$CHECKSUM_FILE"

echo ""
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "  ${GREEN}ALL $PASSED FILES VERIFIED${NC}"
    echo -e "  ${GREEN}No tampering detected.${NC}"
    echo ""
    echo -e "  ${CYAN}Safe to install.${NC}"
else
    echo -e "  ${RED}WARNING: $FAILED/$TOTAL FILES FAILED VERIFICATION${NC}"
    echo -e "  ${RED}DO NOT INSTALL — files may have been tampered with.${NC}"
    echo ""
    echo -e "  ${YELLOW}Re-clone from the official repo:${NC}"
    echo -e "  ${WHITE}git clone https://github.com/MEHDIGAMER/power-range-elite.git${NC}"
fi

echo ""
