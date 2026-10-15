# Issue #1 implementation plan

Authority: owner's CODEX TASK 001, issue #1, AGENTS.md and existing technical architecture. Implementation is authorized; no new creative decisions are required.

1. Preserve the three source mappings. Bind Rojo to localhost, explicitly preserve Studio-owned instances outside source folders, and pin Rojo 7.7.1.
2. Add strict shared Config and Logger modules. Bootstrap errors include a traceback and never print successful startup after failure.
3. Add a server-only state machine (Booting, Lobby, Gameplay, Ending, Shutdown). Test valid/invalid transitions, abort, repeated requests, independent instances and terminal shutdown. Boot only reaches Lobby; other states are extension points, not implemented gameplay.
4. Add idempotent player lifecycle start/stop. Connect before enumerating existing players; ignore duplicate joins and stale removal; disconnect and clear references on stop. Keep Roblox default character spawning. Cover lifecycle with an isolated Studio test harness.
5. Provide a dependency-free Windows structural validator, Luau unit tests and a separate Rojo Studio test project. Add CI for official Rojo builds and Luau compilation/unit tests. Never substitute these checks for Studio runtime evidence.
6. Document installation, sync ownership, solo/two-client testing, private publishing and actual verification results. Commit on feat/1-project-foundation; open PR for owner review; do not merge or advance milestones.

Review focus: missing replicated modules; duplicate startup/join events; leave/rejoin cleanup; illegal state progression; accidental deletion of Studio-owned content. No gameplay, remotes, voice, assets or visual design in this issue.

Environment ruling: local Git cannot resolve github.com. Source is prepared from the pinned main snapshot and delivered through GitHub Git-object APIs with an expected-head lease, preserving all unmodified files. Rojo/Luau/Studio runtime checks must remain blocked until an executable environment is available.

Execution record: implementation and Windows setup delivered in PR #9. Local structure passed; GitHub CI provided an executable environment and verified Rojo builds, compilation, pure-module analysis and 19 state behavior assertions. Studio/publishing remain pending. Independent review found no blocking defect. No later milestone started.
