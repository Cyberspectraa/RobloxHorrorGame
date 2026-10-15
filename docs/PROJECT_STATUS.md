# Project status / handoff - 2026-10-15
## Current confirmed facts
- Repository Cyberspectraa/RobloxHorrorGame started empty; the Issue #1 feature branch adds a Rojo foundation, typed bootstrap/config/logging, server-only state and player lifecycle, tests and Windows setup. Roblox runtime status: **IMPLEMENTED-UNTESTED**; see docs/FOUNDATION_VERIFICATION.md. This is not a statement that the PR is merged.
- Official Roblox docs confirm client-side AudioAnalyzer volume and optional speech-to-text APIs; practical voice eligibility and integration have NOT been tested.
- No Roblox Studio place, playable loop, finished creature, music track, final sound asset, uploaded gamepass or publishable experience has been created or verified.
- Phase: M0 pre-production completed as a design draft; M1 foundation implemented for review, but Studio/private-place acceptance remains pending. No later milestone started.

## Created GitHub issues - source of task scope
- #1 M1 Foundation / Rojo / private Studio sync - **implementation prepared; awaiting Studio evidence and owner review**
- #2 World sound events + attenuation
- #3 The Return AI perception/navigation (depends on #2)
- #4 Opt-in mic AudioAnalyzer implementation (depends on #1 and #2)
- #5 Bespoke menu and accessibility settings (coordinate mic toggle with #4)
- #6 Detailed first switchgear wing and circuit puzzle (depends on #1)
- #7 Original audio, ambience, captions
- #8 All endings, replay and cosmetic passes
See issue descriptions for acceptance, file ownership and PR requirements.

## Owner decision - 2026-10-15
- **APPROVED**: keep THE RELAY BELOW in the **psychological and realistic horror** direction, not supernatural/reality-distortion horror and not constant aggressive survival horror. Believable facility, slow dread and sound-hunting creature are now binding creative guardrails. See docs/GAME_DESIGN.md and docs/ART_DIRECTION.md.
- This approval is **creative scope**, not implementation verification or blanket approval of every provisional feature.

## Pending owner design sign-off
- THE RELAY BELOW name, Bracken Point setting, The Return antagonist and the 3 endings.
- First-person 1-4 players, target 25-40 min, cosmetic-only monetization.
- Platform device priorities after desktop vertical slice.

## Collaboration handoff
A new ChatGPT/Codex session must read AGENTS.md, this file, and the relevant issue before making changes. Claim only one issue/owned file set per feature branch. PRs, not cross-chat memory, transmit implementation decisions. Owner playtests and merges before marking VERIFIED. The preferred first implementation task is issue #1, not starting all issues simultaneously.

## Verification legend
PROPOSED = design only; IMPLEMENTED-UNTESTED = code exists but has not passed Studio; VERIFIED = witnessed playtest/log; RELEASED = published and validated.
