# Changelog

All notable changes to this specification are listed here.
The format follows [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/),
and versions follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-11-07

### Changed

- VCS-006: committing with a no-reply email address is now optional (MAY) instead of recommended (SHOULD). Each contributor chooses whether their address appears in the public history.

## [0.2.1] - 2026-11-04

No rule changes.

### Changed

- Each page links the outside standards it names, including RFC 2119 and RFC 8174 in the conformance text.
- Each page that cites outside sources ends with a References section, with an archived copy of each source.
- English text uses US spelling. The README heading is now "License".
- `.fpsot-checks` turns on the references and US spelling checks in CI.

## [0.2.0] - 2026-11-03

No requirement changes meaning.

### Added

- A book per language, published as PDF with each release, ending with a glossary.
- A document history at the end of each page.
- `AGENTS.md`.
- Comparison data for four topics: signed commits, commit messages, release versions and branch protection, with one Canada row on signed commits.

### Changed

- Conformance cites WRT-010 and WRT-011 of the FPSOT writing specification. The French page now quotes the RFC 8174 text.
- Abbreviations and defined terms link to the glossary.
- The guide has the page type how-to.
- `NOTICE` spells out FPSOT. `NOTICES.md` drops the template instruction.

## [0.1.1] - 2026-11-01

### Fixed

- VCS-001: the rationale now matches squash merges. GitHub signs the commit on `main`; the author signs each pull request commit.
- VCS-002: unsigned commits are rejected in pull requests too, not only on protected branches.
- VCS-107: a release branch is created only after the next major version ships.
- VCS-108: Sigstore gitsign is no longer listed, because GitHub does not verify its signatures.
- `rules/apply-github.sh --checks` makes the CI checks required before a merge.

## [0.1.0] - 2026-11-01

### Added

- Generic rules VCS-001 to VCS-006: signed commits, Conventional Commits, one change per commit, issue links, no-reply email.
- Git rules VCS-101 to VCS-110: trunk-based development, branch names, squash merges, signed release tags, release branches, signing keys, branch protection.
- GitHub ruleset and `rules/apply-github.sh`.
- Guide on signing, email privacy, branch names and releases.
- French text reviewed by the project lead.

[Unreleased]: https://github.com/fpsot-org/fpsot-spec-vcs/compare/v0.2.1...HEAD
[0.2.1]: https://github.com/fpsot-org/fpsot-spec-vcs/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/fpsot-org/fpsot-spec-vcs/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/fpsot-org/fpsot-spec-vcs/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/fpsot-org/fpsot-spec-vcs/releases/tag/v0.1.0
