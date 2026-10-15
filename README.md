# THE RELAY BELOW

A first-person, sound-driven survival horror experience for Roblox.

**Status: pre-production.** The repository now contains the creative brief, design bible, microphone feasibility/specification, production roadmap, technical architecture, asset plan, and collaboration contract. It is **not yet a playable build**.

## Read first
- [Game design](docs/GAME_DESIGN.md) — story, loop, location, puzzles, creature, endings, monetization.
- [Art direction](docs/ART_DIRECTION.md) — visual language, bespoke identity, typography, title screen, UX.
- [Voice specification](docs/VOICE_SYSTEM.md) — Roblox API research, opt-in logic, privacy, fallbacks and implementation gates.
- [Audio direction](docs/AUDIO_DIRECTION.md) — original score, sound design, dynamic mixing, subtitles.
- [Architecture](docs/TECHNICAL_ARCHITECTURE.md) — Rojo project layout and server/client responsibilities.
- [Production roadmap](docs/PRODUCTION_PLAN.md) — milestones, acceptance gates and playtests.
- [Project status](docs/PROJECT_STATUS.md) — what is actually finished.
- [Asset register](docs/ASSETS.md) — art/sound provenance and tracking.
- [Agent instructions](AGENTS.md) — mandatory handoff rules for ChatGPT, Codex and anyone contributing.

## Build pipeline (planned)
Roblox Studio + Rojo source synchronization + Git feature branches and pull requests. A Roblox Studio place and verified microphone integration are still required. Do not publish or claim the game is finished until the gates in the roadmap pass.

## Working agreement
The GitHub repository is the **only persistent source of truth** shared by ChatGPT and Codex. Normal chat messages are not project commits; Codex cannot be expected to read those messages. One subsystem per branch, no concurrent edits to the same files, and no direct feature changes to main. See AGENTS.md.
