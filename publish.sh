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

TITLE=${2//$'\n'/ }
DATE=$(date +%Y-%m-%d)

if ! [[ "$1" =~ ^[0-9]{1,2}$ ]]; then
  echo "[-] Day must be a whole number (e.g. 1, 2, 30)." >&2
  exit 1
fi
DAY=$(printf "%02d" "$((10#$1))")

SLUG=$(printf '%s' "$TITLE" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' \
  | cut -c1-80)
[ -z "$SLUG" ] && SLUG="update"

# Escape for a YAML double-quoted scalar.
ESC_TITLE=$(printf '%s' "$TITLE" | sed 's/\\/\\\\/g; s/"/\\"/g')

mkdir -p _posts
FILE="_posts/${DATE}-day-${DAY}-${SLUG}.md"

if [ ! -f "$FILE" ]; then
  {
    printf -- '---\n'
    printf 'layout: post\n'
    printf 'title: "Day %s: %s"\n' "$DAY" "$ESC_TITLE"
    printf 'date: %s\n' "$DATE"
    printf 'day: %s\n' "$((10#$1))"
    printf 'bugs: 0\n'
    printf -- '---\n'
    cat <<'BODY'
**Time spent:**
**Audit cost deducted:** $

### Methodology & pipeline
-

### Results
- **Raw alerts:**
- **Verified PoCs:**
- **False positives:**

### Notes & friction points
-
BODY
  } > "$FILE"

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
