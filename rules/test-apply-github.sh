#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Tests apply-github.sh in dry-run mode: no call reaches GitHub.
set -u
here="$(cd "$(dirname "$0")" && pwd)"
fail=0
out="$(bash "$here/apply-github.sh" --dry-run fpsot-org/example 2>&1)"; rc=$?
[ $rc -eq 0 ] || { echo "FAIL: exit $rc"; fail=1; }
for want in "repos/fpsot-org/example/rulesets" "allow_merge_commit=false" "allow_rebase_merge=false" "allow_squash_merge=true" "squash_merge_commit_title=PR_TITLE" "delete_branch_on_merge=true"; do
  case "$out" in *"$want"*) ;; *) echo "FAIL: output lacks $want"; fail=1 ;; esac
done
bash "$here/apply-github.sh" --dry-run >/dev/null 2>&1 && { echo "FAIL: missing repo argument must fail"; fail=1; }
python3 -c 'import json,sys; r=json.load(open(sys.argv[1])); t={x["type"] for x in r["rules"]}; need={"deletion","non_fast_forward","required_signatures","required_linear_history","pull_request"}; sys.exit(0 if need<=t and r["name"]=="fpsot-vcs" else 1)' "$here/github-ruleset.json" || { echo "FAIL: ruleset content"; fail=1; }
[ $fail -eq 0 ] && echo PASS
exit $fail
