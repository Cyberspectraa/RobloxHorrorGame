# Technical architecture and scope ownership
Status: foundation implemented for Issue #1; Roblox runtime verification pending. Gameplay services below remain planned.

## Tooling
Roblox Studio authoring + source-controlled Luau with Rojo (rojo-rbx) for script synchronization. Editor may be VS Code + Luau tooling, but Roblox Studio remains required for environment assembly, GUI/asset previews and genuine runtime tests. GitHub for PRs, Issues and release tags. Keep dependencies minimal until a need is demonstrated.

## Planned source layout
default.project.json maps:
- src/shared -> ReplicatedStorage/Shared, with typed messages, shared config and constants.
- src/server -> ServerScriptService/Server, with boot, gameplay, entity AI, puzzle graph, endings, saves.
- src/client -> StarterPlayer/StarterPlayerScripts/Client, with view/UI, mic envelope reader, captions, accessibility.
- assets/ eventually holds text-based metadata/manifests and export pipeline; Roblox uploaded binary meshes, audio and Studio place backups need explicit management.

Rojo alone is not a replacement for all Studio-authored meshes, animations and place data. Decide later between maintained .rbxlx scene snapshot or reproducible map-source process. Do not claim the repository completely rebuilds the world until tested.

## Runtime services (planned)
- RoundService (server): lobby -> briefing -> shift -> choice -> ending; reconnect/leave handling.
- ObjectiveService (server): authored dependency graph, reliable cooperative interaction and solo scaling.
- InteractionService (server): validation of proximity, inventory and target.
- NoiseService (server): sound blackboard sourced from server-simulated world actions plus bounded opt-in client mic categories.
- CreatureService (server): AI finite state machine with search memory, deterministic bounds and PathfindingService route checks.
- MapService (server): streamed sections, room acoustic graph and route randomisation.
- EndingService (server): validates choices, optional archive evidence and completion.
- ProgressService (server): cosmetics/unlocks when ready, DataStore writes with retry/limits.
- ClientAudioMeter (client): Roblox AudioAnalyzer envelopes, calibrated local-only, sends bands if opted in.
- ClientPresentation (client): radio screen/menus, cinematic sequences, UI controls, subtitles, intro.
- AudioDirector (client): 3D ambience and score stems from server AI states with smoothing.
- Shared Protocol: schema/enum definitions, no arbitrary remote object instance injection.

## Server trust
All progression, interaction, enemy pathing, player death, unlocks and monetization decisions reside server side. Validate remotes by UserId, expected state, cooldown, distance, type and range; reject malformed or repeated requests. Do not forward literal STT transcripts. Mic measurements are untrusted optional atmosphere signals only. Respawn, disconnection and checkpoint restoration must not stall the whole group.

## AI implementation plan
Use a server-driven blackboard with scored recent acoustic events (strength, material, door state, age) plus sight detections. Tick perception at controlled rates (~5–10 Hz), navigation less often unless target changes. Explicit hysteresis prevents thrashing between sounds; attack distance/vision must be fair, independent of frame rate. World line-of-sight and navigation blockers must use authored collision geometry; no through-wall cheating. Clean up connections and cached per-player data on leaving.

## Quality and platform requirements
Single publishable place initially to reduce cross-place teleports; separate lobby in same environment. StreamingEnabled only when room unload behavior audited, with persistent critical objective models when appropriate. Controller/gamepad input and mobile touch layouts tracked before release. Set graphics fallback for particles, postprocessing and soft shadows; measure low-end hardware. Build an asset budget and record performance metrics, not 'looks smooth' by impression.

## Issue #1 foundation and setup appendix
Use [STUDIO_SETUP.md](STUDIO_SETUP.md) for Windows installation, Rojo 7.7.1, source ownership, CLI checks, Studio solo/two-client tests and private publishing. Actual evidence and limitations are in [FOUNDATION_VERIFICATION.md](FOUNDATION_VERIFICATION.md).

- Shared `Config` holds public settings only; `BuildInfo.IsPlayable` stays false. `Logger.new(scope, debugEnabled)` produces consistent INFO/DEBUG/ERROR messages, with debug off by default. No remote telemetry or player/audio payload logging.
- Both bootstrap entry points catch startup failures with tracebacks. Client dependency waits are bounded to avoid silent infinite waits during incomplete replication/sync. Server dependencies are expected to exist in the built tree; missing dependencies fail immediately after the Shared folder check.
- `Foundation/PlayerService.new()` exposes `start()`, `stop()`, `getCount()` and `contains(player)`. It subscribes before enumerating players, deduplicates joins, keys records by the Player instance, and disconnects/clears records on stop. Start/stop are idempotent; no character connections, custom respawn, persistence or join remotes are added.
- `Foundation/StateMachine.new()` exposes `getState()` and `transition(nextState) -> (boolean, string?)`. Booting -> Lobby -> Gameplay -> Ending -> Lobby; Gameplay -> Lobby permits future aborts; all live states permit terminal Shutdown. Invalid/duplicate transitions do not mutate state. This server-only module is a lifecycle primitive, not RoundService or implemented game progression. Future round coordination must own an instance and call its API; the current bootstrap instance is intentionally private.
- Bootstrap starts tracking players, enters Lobby, and binds cleanup to server shutdown. No automatic transition to Gameplay, replication, timers or polling. Future UI networking is a separate reviewed contract; no client inputs are accepted now.
- Production Rojo maps only the original three source folders and preserves unknown siblings outside them. The test project is separate and must not be published or synced into production.
- Default Roblox character spawning remains enabled by the Studio place; the source build contains no world geometry. Use a disposable Baseplate for spawn testing. Studio-authored assets still need a later export decision.

Do not enable voice APIs or begin the vertical slice as part of #1. Voice remains dependent on the separate eligibility/opt-in work and actual eligible-user tests.

## ADRs (pending)
ADR-001: Lobby and gameplay in one place initially, yes.
ADR-002: Non-mic path is a full equal experience, yes.
ADR-003: No arbitrary cloud AI/TTS service or voice recording, yes.
ADR-004: Source-controlled world assets format to be selected after first map test.
