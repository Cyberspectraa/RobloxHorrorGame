# Game design bible v1 — THE RELAY BELOW
Date: 2026-10-15. Status: proposed creative baseline, subject to owner approval.

## One-sentence pitch
During a night shift beneath an isolated British coastal relay station, 1–4 operators restore a failed warning network while being hunted by a thing that interprets every sound as an invitation.

## Product and principles
Platform Roblox; first-person, solo/co-op 1–4; desktop-first at prototype stage with gamepad and mobile support targeted before public release; nominal first run 25–40 minutes. Replay comes from different valid route sequences, varied item locations, adaptive search patterns and optional records, not a grind. Psychological atmosphere, spatial audio, and deliberate fear. No gore required. Target audience rating to be chosen in Roblox compliance questionnaire.

Pillars: 1) Every noise has an understandable consequence. 2) Quiet has a cost because machines demand noisy actions. 3) Cooperating helps but never requires voice chat or another player. 4) Good environmental storytelling beats cheap jumpscares. 5) Trust the player's intelligence; puzzles use environmental logic instead of random guessing.

## Setting, date and story
1996, fictional Bracken Point on a tidal stretch of the British coast. Below a weather-warning radio station lies Relay Site 08, a sealed experimental acoustic routing complex. After an unexplained blackout, a maintenance crew arrives with an instruction: restore the emergency coastal signal before the coming tide floods the lower floors. Its late staff appear to have left recordings detailing a noise-mapping machine that began returning transmissions before they were sent.

The facility is a plausible layered environment: arrival gantry, service spine, switchgear plant, tape archive, listening galleries, water intake and central transmission chamber. The antagonist is not a random ghost. Its 'body' is formed around the routing equipment and it reacts to mechanical resonance and voices. Documents never completely settle whether it is an entity, a failed experiment, or a signal occupying matter.

## The entity: THE RETURN
Visual: extraordinarily tall, asymmetric human silhouette wrapped in taut telephone wire and black rubberised cabling, with an industrial ceramic listening horn in place of a face and delicate vibrating diaphragm membranes on its ribs. Copper contacts spark only when it detects a nearby sound. No monster-red glowing eyes, default Roblox skeleton, or constant full reveal. Shape language: negative space, bent conductor lines, ceramic curves and unsettling stillness.

Audio signature: first a remote three-pulse relay knock (slow, slow, short), then a soft reversal of nearby machinery. Hearing it does not always mean imminent death. The creature can move indirectly via maintenance passages, emerge between aisles and physically traverse valid paths rather than teleporting directly into player view. Scripted traversal of unseen service ducts can reposition it when no players observe the entry/exit.

AI: DORMANT (low activity) -> PATROL (route) -> INVESTIGATE (plausible last sound source) -> SEARCH (sweep nearby cover) -> PURSUE (confirmed visibility or close sound) -> RECOVER (cooldown and deceptive return). Server remains authoritative. Sound events carry type, location, strength and lifetime. Sound is reduced by distance, rooms/doors and interference. Line of sight, last-known position, recent hiding spot investigation and noise compete for targets. It should sometimes *choose* a strong machine noise over weak voice input. No perfect wall-vision, no certain death from a single cough, no sprint-forever exploit. Higher difficulty increases persistence rather than raw speed alone.

On catching a player: brief disturbing loss-of-signal sequence, non-graphic capture, safe respawn/observation with objective costs; in co-op, a limited team rescue route is possible. No purchases tied to survival.

## Player and tools
A constrained first-person camera, believable acceleration, walking, crouching and a limited sprint burst with recoverable breath. Player makes world-generated footstep and interaction sounds. Crouching reduces footprint but slows travel; running helps escape at a noise cost. No tedious stamina bar across the centre of the screen.

Tool kit with only meaningful items: hand-cranked inspection light (reliable narrow beam, crank makes sound); resonator puck (single-use timed noise decoy, obtainable in-world); archive reader key (contextual access card, no endless coloured keys); folded schematic (diegetic annotated map, updated when you discover rooms). Each player carries one major tool and an objective item; co-op trades optional, solo always possible.

## Gameplay cycle
Explore -> interpret mechanical clues -> choose whether to run a noisy machine -> create/manipulate a sound -> entity investigates -> navigate altered threat routes -> restore another section -> uncover moral decision. The enemy should always have valid counterplay: silence, hiding with limits, distractions, movement through alternate routes, shutting a door (itself noisy).

## Level topology and authored rhythm
Arrival Gantry: brief rain and sea sounds; instruction book and maintenance checkpoint; safe onboarding of move, crouch and sound source. Incident 1 teaches footsteps and metal grating; first glimpse through obscured glass.

Service Spine: central hub with hand-drawn signage, two circulation loops and a shortcuts system. This is the navigation landmark.

Switchgear Plant: route current across substations using visible numbered isolators and a working wall diagram. Must start a loud generator; team can coordinate watch and operator positions, solo can pre-position a distraction. First true hunt.

Tape Archive: retrieve three fragments by listening/reading analogue tape labels and connecting line numbers. Noise from machine playback competes with voice noise. Optional lore records and evidence for ending. The return repeats the three-pulse signal behind a locked shutter.

Listening Galleries: movable dish orientation and tone meter; use visual oscillation as an equal alternative to hearing pitch. The creature shadows behind acoustic glass. The player realises the system does not broadcast; it receives future noise.

Water Intake: rising tide timer indicated by physical water marks, valves and alarm lights, with generous windows and no unavoidable death. Several routes into an exposed service deck. The system is now awake.

Transmission Chamber: route the final signal using clues gathered in earlier rooms. The group must choose an ending. Departure sequence uses a chase only when narratively justified; decisions determine the conclusion rather than which paid item is held.

Area pacing target: arrival 4 min, switchgear 6–7, archive 6–7, galleries 5–7, intake 4–5, finale 4–6; ranges to rebalance through playtest. Randomize which two midgame wings unlock first, which valid isolator layout is active and where some nonessential salvage lies. Never randomize required code clues into inaccessible locations.

## Puzzles and multiplayer scaling
- Switchgear: inspect schematic; route coloured/coded current via physically labelled breakers. Server validates a circuit graph, no brute-force 4-digit PINs.
- Archive: match redacted work orders to physically located tape spool serials; players can read captions instead of listening.
- Gallery: use an oscilloscope waveform and physical dish handles to match an indicated reference; no perfect pitch needed.
- Intake: open two pressure release gates in sequence with a believable physical flow clue; co-op parallelism optional; solo lever remains latched long enough.
- Finale: choose a destination for the recovered signal, not a trivia quiz.

Each puzzle has readable feedback, safe reset, an optional escalating diegetic hint, and a solo path. Failure adds a cost (noise/time) rather than permanent softlock. Loud actions change actual AI hearing, not just a fake red meter.

## Endings (three, all attainable without microphone)
1. CUT THE LINE — physically isolate the station and escape on the tide rail. The entity is contained, evidence is lost; bittersweet standard ending.
2. BROADCAST — transmit the warning and recordings to the surface. The world hears the evidence and potentially the entity too; unsettling risky ending.
3. ZERO RETURN — decode the original fault pattern, deliver a calibrated inverse phase via stations visited, and sever the feedback without erasing staff messages. More demanding hidden but fair ending requiring optional evidence and understanding, not collectibles count or Robux.

Post-game dossier records decisions, evidence discovered and playtime; optional chapter replay and cosmetic reward. No false 'true ending' paid gate.

## Screens, lobby, flow
Launch -> title/first-run accessibility and microphone choice -> diegetic menu -> solo/create crew/join friends -> 4-player lobby with equipment lockers, voice indicator and game rules -> shift briefing -> playable shift -> end sequence -> archived report/results -> optional replay.

Intro: a dark close-up of a relay switch board; the camera pans past moisture-streaked bakelite to a paper strip that slowly prints STATION 08 / SHIFT UNFILLED. A relay clicks three times and one indicator stays illuminated when the menu appears. No stock Roblox obby lobby or generic glowing START button. Skip intro instantly on repeat runs. In lobby players stand on the rain-lashed loading gantry, not a featureless box.

Menu layout: left aligned log sheet, typographic station stamp, utility buttons labelled BEGIN SHIFT / CREW / RECORDS / SETTINGS / CREDITS, with thin horizontal rules and a small date/time plate. On selection, a physical mechanical arm changes position and the scene reveals a new layer. In-run HUD nearly invisible: tiny equipment label bottom-left, foldout task sheet, tasteful world-space signage, crosshair only on interactables. Menu disabled during capture and restored appropriately.

## Distinctiveness and polish
Not a pastiche of Doors or Pressure; no numbered room grinding, door key roulette, 'monster always appears after 30 seconds', red filter, monster overexposure, cheap stock fonts, incoherent random ambience, or AI-generated texture noise as decoration. Every repeated visual mark should belong to the station's brand and function.

## Business model (proposed, NOT live)
First release should be fully free and completable. Cosmetic-only passes after gameplay quality is proven:
- FOUNDERS' DOSSIER (candidate 79 Robux): profile stamp, lobby locker plate and alternative ending-report paper stock.
- SIGNAL TECHNICIAN (candidate 49 Robux): cosmetic hand-crank casing and equipment label styles; same light strength/noise.
- ARCHIVE EDITION (candidate 99 Robux): optional alternate photocopy UI treatment and special title-menu cassette; no clues obscured, no exclusive puzzle information.
Prices are preliminary and subject to platform review. No paid revives, premium safe zones, 'silent mic', louder hearing, extra health, loot boxes, paid ending, or pay-to-win tools. Keep a cosmetic earnable path.

## Quality targets
15-second opening hook; tutorial discoverable without walls of text; players understand why they were heard; first credible threat within 4–6 min; 1–4 players supported; 100% complete with voice disabled, speakers muted and captions enabled; no unlicensed or synthetic-looking filler assets; publish only after Studio and live voice tests pass.
