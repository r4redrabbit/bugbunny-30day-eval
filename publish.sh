#!/usr/bin/env bash
# Create or publish a daily BugBunny evaluation post.
#
# Usage:
#   ./publish.sh 1 "Testing SSRF on Example.com"   # create the draft post
#   ./publish.sh 1 "Testing SSRF on Example.com"   # re-run after editing -> commit + push
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <day-number> <title>" >&2
  exit 1
fi

DAY=$(printf "%02d" "$1" 2>/dev/null || true)
TITLE="$2"
DATE=$(date -u +%Y-%m-%d)

if ! [[ "$DAY" =~ ^[0-9]{2}$ ]]; then
  echo "[-] Day must be a number (e.g. 1, 2, 30)." >&2
  exit 1
fi

SLUG=$(printf '%s' "$TITLE" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' \
  | cut -c1-80)
[ -z "$SLUG" ] && SLUG="update"

ESC_TITLE=$(printf '%s' "$TITLE" | sed 's/\\/\\\\/g; s/"/\\"/g')
FILE="_posts/${DATE}-day-${DAY}-${SLUG}.md"

if [ ! -f "$FILE" ]; then
  cat > "$FILE" <<EOF
---
layout: post
title: "Day ${DAY}: ${ESC_TITLE}"
date: ${DATE}
---
**Time spent:**
**Audit cost deducted:** \$

### Methodology & pipeline
-

### Results
- **Raw alerts:**
- **Verified PoCs:**
- **False positives:**

### Notes & friction points
-
EOF
  echo "[+] Created ${FILE}"
  echo "    Edit it, then re-run this command to commit and publish."
  exit 0
fi

git add "$FILE"
if git diff --cached --quiet; then
  echo "[=] No staged changes for ${FILE}; nothing to publish."
  exit 0
fi

git commit -m "docs: publish Day ${DAY} update"
git push -u origin HEAD
echo "[+] Day ${DAY} published."
