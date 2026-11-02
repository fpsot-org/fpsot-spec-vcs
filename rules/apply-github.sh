#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
#
# Applies the VCS rules to a GitHub repository:
#   - the "fpsot-vcs" ruleset (VCS-002, VCS-104, VCS-109, VCS-110), created or updated;
#   - repository merge settings (VCS-104, VCS-105): squash only, PR title as the commit title.
# Needs the gh CLI, logged in with admin rights on the repository.
#
# Usage: apply-github.sh [--dry-run] OWNER/REPO
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dry=0
if [ "${1:-}" = "--dry-run" ]; then dry=1; shift; fi
repo="${1:-}"
if [ -z "$repo" ] || [ "${repo#*/}" = "$repo" ]; then
  echo "usage: apply-github.sh [--dry-run] OWNER/REPO" >&2
  exit 2
fi

call() {
  if [ $dry -eq 1 ]; then echo "gh api $*"; else gh api "$@"; fi
}

id=""
if [ $dry -eq 0 ]; then
  id="$(gh api "repos/$repo/rulesets" --jq '.[] | select(.name == "fpsot-vcs") | .id')"
fi
if [ -n "$id" ]; then
  call -X PUT "repos/$repo/rulesets/$id" --input "$here/github-ruleset.json" >/dev/null
else
  call -X POST "repos/$repo/rulesets" --input "$here/github-ruleset.json"
fi

call -X PATCH "repos/$repo" \
  -F allow_squash_merge=true \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -f squash_merge_commit_title=PR_TITLE \
  -f squash_merge_commit_message=PR_BODY \
  -F delete_branch_on_merge=true
