---
name: fpsot-vcs
description: Version control rules for FPSOT repositories. Use when committing, naming branches, opening or merging pull requests, tagging releases, or setting up a Git repository.
---

# FPSOT version control

Summary of the FPSOT version control specification. It adds no rules of its own.
The spec text in `spec/` wins on any difference. Each line cites its requirement ID.

## Commits

- Sign every commit (VCS-001). Protected branches and pull request checks reject unsigned commits (VCS-002).
- Write Conventional Commits messages: `type(scope): summary` (VCS-003).
- One logical change per commit (VCS-004). Reference the issue when one exists (VCS-005).
- Commit with a no-reply email address (VCS-006).

## Branches and merging

- Keep `main` releasable. Use trunk-based development, never Git flow (VCS-101).
- Name work branches `<type>/<short-description>`, such as `feat/search` (VCS-102).
- Merge or close work branches within days (VCS-103).
- Squash-merge pull requests. Merge commits and rebase merging stay off (VCS-104).
- Give each pull request a Conventional Commits title (VCS-105).

## Releases and protection

- Release with a signed, annotated `vX.Y.Z` tag (VCS-106).
- Create `release/N.x` only to fix major version N after version N+1 ships (VCS-107).
- Prefer SSH signing keys. GPG keys are fine. GitHub does not verify Sigstore gitsign, so do not use it (VCS-108).
- `main` and `release/*` require a pull request and signed commits (VCS-109), and block force-pushes and deletion (VCS-110).
- `rules/apply-github.sh OWNER/REPO` applies VCS-002, VCS-104, VCS-105, VCS-109 and VCS-110 on GitHub.
