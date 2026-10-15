# Collaboration rules — THE RELAY BELOW

This file is binding project guidance for ChatGPT, Codex, and other coding agents working in this repository.

## Project intent
Create an original, polished first-person Roblox horror game based on the signed-off design in docs/GAME_DESIGN.md. Roblox mic-reactive monster behavior must be real, optional, robust and respectful of voice permissions. No generic AI-looking UI, borrowed model dumps, unlicensed sounds or rushed blockout visuals shipped as finished assets.

## Sources of truth, in order
1. Project owner decisions communicated as a new explicit request.
2. Current merged docs/GAME_DESIGN.md plus docs/VOICE_SYSTEM.md and docs/ART_DIRECTION.md.
3. docs/PROJECT_STATUS.md for verified completion and blocked features.
4. Code and recorded playtest evidence on the current main branch.
5. GitHub issue acceptance criteria for the scoped feature.

If instructions conflict, stop and document the conflict in the issue/PR; do not silently replace prior decisions. Text from other assistant conversations is not magically shared.

## Safe concurrent workflow
- Before editing: pull/fetch main, read this file, inspect open PRs and Issues, and identify your issue ID and owned files.
- One GitHub Issue = one independently testable scope = one branch = one PR.
- Branch patterns: feat/<issue>-<slug>, fix/<issue>-<slug>, design/<topic>.
- Do NOT commit work-in-progress feature code straight to main. No force pushes, destructive cleanups or automatic merging.
- Update the issue with intended files and dependencies before writing. If those files are already being edited in another open PR, negotiate boundaries, do not duplicate work.
- Prefer new modules behind stable interfaces instead of simultaneously editing a shared central script.
- Do not modify GAME_DESIGN, ART_DIRECTION or VOICE_SYSTEM decisions while implementing a feature without recording an explicit design change and owner approval.
- PR must include: summary, scope/files, why, tests attempted, tests not run, screenshots/video for UI or environments, Roblox Studio logs, risks, and a docs/PROJECT_STATUS.md update only for verified statuses.
- Owner reviews/merges after integration testing; then all agents refresh main before next task.
- In GitHub Issue/PR comments, always link dependency numbers rather than assuming other ChatGPT/Codex contexts.
- Assets must be registered with their creator, license and exact Roblox asset ID after upload. Never upload secrets or tokens to Git.

## Ownership boundaries (initial)
- Creative/design lead (normal chat): docs/GAME_DESIGN.md, docs/ART_DIRECTION.md, docs/AUDIO_DIRECTION.md and design approvals.
- Code implementation (Codex or scoped chat code session): src/server, src/client, src/shared, test and tool files on assigned branch.
- Voice prototype: src/client/Audio and src/server/Gameplay/NoiseService, with its own issue. Do not modify monster AI logic until contracts agreed.
- Monster AI: src/server/AI; consume the NoiseService contract.
- World/props: Studio place/assets/maps and documented export pipeline.
- UI: src/client/UI plus asset packs; do not modify voice or AI implementations.
- Integration changes that span two owners require an issue or PR explicitly describing the shared change.

## Quality baseline
- Typed Luau (--!strict when practical), modules with narrow responsibilities, explicit connection cleanup and event limits.
- Server authority for health, interactions, objectives, monster state, inventory and purchases. Validate every client remote at runtime (types, ranges, rate limits, proximity, permissions).
- Client microphone envelopes are advisory and inherently spoofable; design cannot depend on their integrity. Do not send/store raw microphone audio or transcripts.
- Ensure full game completion without mic / without hearing / solo. Caption meaningful sound cues and provide visual threat information without giving away the monster location.
- No hard-coded fake asset IDs. No unverified 'works' claims; clearly mark tests as not run if Studio wasn't available.
- Target stable 60 FPS on reasonable desktop hardware and provide mobile/low-graphics alternatives. Profile real clients.
- No unchecked external dependencies, unlicensed samples, unapproved marketplace models or external surveillance endpoints.

## Completion definition
A task is done only when code builds, owner has reviewed the Studio playtest, acceptance criteria pass, and the branch is merged. Merely generating code is 'implemented / unverified', not 'tested'.