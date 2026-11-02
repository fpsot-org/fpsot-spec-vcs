#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
#
# Applies the VCS rules to a GitHub repository:
#   - the "fpsot-vcs" ruleset (VCS-002, VCS-104, VCS-109, VCS-110), created or updated;
#   - with --checks, the named CI checks must pass before a merge;
#   - repository merge settings (VCS-104): squash only, PR title as the commit title.
# Needs the gh CLI and python3, logged in with admin rights on the repository.
#
# Usage: apply-github.sh [--dry-run] [--checks "job / check,..."] OWNER/REPO
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dry=0
checks=""
while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) dry=1; shift ;;
    --checks) checks="${2:-}"; shift 2 ;;
    *) break ;;
  esac
done
repo="${1:-}"
if [ -z "$repo" ] || [ "${repo#*/}" = "$repo" ]; then
  echo "usage: apply-github.sh [--dry-run] [--checks \"job / check,...\"] OWNER/REPO" >&2
  exit 2
fi

ruleset="$(mktemp)"; trap 'rm -f "$ruleset"' EXIT
python3 - "$here/github-ruleset.json" "$checks" > "$ruleset" <<'PY'
import json, sys
rules = json.load(open(sys.argv[1]))
names = [c.strip() for c in sys.argv[2].split(",") if c.strip()]
if names:
    rules["rules"].append({
        "type": "required_status_checks",
        "parameters": {
            "strict_required_status_checks_policy": False,
            "do_not_enforce_on_create": False,
            "required_status_checks": [{"context": n} for n in names],
        },
    })
print(json.dumps(rules, indent=2))
PY

call() {
  if [ $dry -eq 1 ]; then echo "gh api $*"; else gh api "$@" >/dev/null; fi
}

id=""
if [ $dry -eq 0 ]; then
  id="$(gh api "repos/$repo/rulesets?includes_parents=false" --jq '[.[] | select(.name == "fpsot-vcs") | .id] | first // empty')"
fi
if [ $dry -eq 1 ]; then cat "$ruleset"; fi
if [ -n "$id" ]; then
  call -X PUT "repos/$repo/rulesets/$id" --input "$ruleset"
else
  call -X POST "repos/$repo/rulesets" --input "$ruleset"
fi

call -X PATCH "repos/$repo" \
  -F allow_squash_merge=true \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -f squash_merge_commit_title=PR_TITLE \
  -f squash_merge_commit_message=PR_BODY \
  -F delete_branch_on_merge=true
