# Instructions for agents

This repository holds the FPSOT version control specification.

- The normative text is in `spec/en/` and `spec/fr/`. Every rule has an ID such as `VCS-001`.
- Follow `skill/SKILL.md` when you commit, name branches, merge or release in any FPSOT repository. The spec text wins on any difference.
- Every page exists in English and in French, with the same file name and the same IDs.
- Terms and abbreviations come from the term base of `fpsot-spec-writing`. Add a missing term there first.
- `rules/github-ruleset.json` and `rules/apply-github.sh` enforce the rules on GitHub. Run `rules/test-apply-github.sh` after you change them.
- Commits follow Conventional Commits and are signed. Pull requests are squash-merged.
