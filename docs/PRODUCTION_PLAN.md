# Delivery plan and gates — THE RELAY BELOW
Baseline 2026-10-15. This is an ordered plan, not a claim any untested feature exists.

## M0 — Pre-production and repo coordination
Write original design bible, brand/art direction, audio and voice plans, technical architecture, AGENTS contract, state tracker and issue backlog. Investigate Roblox APIs. Exit: repo can be understood by a new coding agent; owner reviews core concept.

## M1 — Testable foundation / vertical-slice shell
Rojo project plus minimal server/client bootstrap, private Roblox Studio place, reliable join/spawn and one visually coherent switchgear room constructed from original assets. Small interaction framework and in-game setting controls. Exit: Studio start/stop without errors, rejoin safe, gamepad/mobile feasibility checks, screenshots with actual designed room. DO NOT ship grey cubes as final art.

## M2 — Sound-first horror (highest-risk integration)
Build authoritative world noise service (footsteps/material, doors, generator, decoy), implement audio blackboard and creature investigative pathing, test threat counterplay. Then implement microphone opt-in, real client AudioAnalyzer input and remote validation. Exit: creature pursues credible noise and cannot be relied on to cheat walls; A–E tests in VOICE_SYSTEM pass with real Roblox accounts; non-mic version works. If voice API is blocked, release still has a complete sound-driven non-mic mode, but do not market voice support until proven.

## M3 — Full first-act loop
Build service hub, switchgear and archive, hand-crank light and decoy, two logical puzzles, distinct in-world intro, full menu/HUD styling and captions. Exit: first 12–15 minutes fun in solo and co-op, first death/rescue flow works, no blockers; test every update.

## M4 — Remaining areas, narrative and finales
Add galleries, water intake, final chamber, original recording story, dynamic route order, 3 endings, replay report and save-safe achievement rewards. Exit: all endings accessible without voice, no impossible randomized combinations; complete run in 25–40 min after tuning.

## M5 — Polish, accessibility, monetization review
Replace all placeholder art/audio with original registered assets; tune entity animation, lighting, mix, caption contrast, calibration, settings and low graphics mode. Implement cosmetic passes only if game is fun and passes review. Exit: 1–4 user real sessions across desktop + controller + touch, voice and non-voice, deaf/caption playthrough, performance profile, compliance questionnaire review.

## M6 — Private beta then public release
Small tester cohort, reproduce and fix bugs with issues, add honest trailer/cover thumbnail, verify game page metadata, content rating, voice restrictions, attribution and privacy copy. No public release until critical issues resolved. Tag versions after approved PR merges; maintain post-launch bug triage and a non-disruptive content roadmap.

## Priority work packets suitable for different branches
A: Foundation/project sync; B: switchgear one-room level; C: noise source and acoustic graph; D: AI search/investigation; E: mic proof of concept; F: original main menu and first-run settings; G: accessible caption layer; H: puzzle state; I: audio director and authored sound sourcing; J: endings and replay. Dependencies: A before B–J; C before D and E; B+C+D needed before believable M2 acceptance; first-room UI can proceed independently once contracts stable.

## Mandatory playtests and logs
After each merged milestone: owner launches private Studio place and supplies screenshot or short video plus Output logs; reproduce solo and at least one 2-client session. Verify start, object interaction, hunt, capture/respawn, escape, mouse lock, camera, sound, captions and leave/rejoin. Track actual result in docs/PROJECT_STATUS.md. Never report a feature 'working' without evidence.

## Release criteria
No known progression softlocks; all three endings work; real mic response with opt-out and ineligible fallback; acceptable server/remote security; no voice recordings/transcript logging; affordable runtime on mobile and desktop; original licensing; documented assets; passes cosmetic-only. For Roblox publishing and content classification, consult current Creator Hub requirements, which may change.
