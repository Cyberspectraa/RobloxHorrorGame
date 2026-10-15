# Microphone-aware AI — feasibility and implementation specification
Status: researched API approach, NOT yet implemented or verified in a published Roblox session (2026-10-15).

## Verified Roblox affordances
Roblox VoiceChatService.UseAudioApi = Enabled exposes AudioDeviceInput for voice-eligible players. AudioDeviceInput produces a mic audio stream. A Wire can connect it to AudioAnalyzer on the LOCAL CLIENT; RmsLevel and PeakLevel are nonreplicated and server AudioAnalyzer audio processing returns zero. AudioSpeechToText can detect speech and provide recognised Text; its VoiceDetected property is local/nonreplicated. Speech-to-text is rate-limited and is not suitable as a continuous guaranteed backend. VoiceChatService:IsVoiceEnabledForUserIdAsync is an eligibility check that may error; guard with pcall. No microphone recording will be used; AudioRecorder documentation explicitly says AudioDeviceInput cannot be recorded and AudioRecorder remains in development.

Primary docs:
https://create.roblox.com/docs/chat/voice-chat
https://create.roblox.com/docs/reference/engine/classes/AudioDeviceInput
https://create.roblox.com/docs/reference/engine/classes/AudioAnalyzer
https://create.roblox.com/docs/reference/engine/classes/AudioSpeechToText
https://create.roblox.com/docs/tutorials/use-case-tutorials/audio/speech-to-text
https://create.roblox.com/docs/reference/engine/classes/VoiceChatService
https://create.roblox.com/docs/audio/objects

## Player flow and consent
On first eligible session, default to microphone gameplay OFF. Show clear controls: 'Mic-reactive danger' ON/OFF; default Roblox voice controls remain respected; local 'test sensitivity' meter with no remote sends; Push-To-Talk is recommended when STT is enabled; mic unavailable => keyboard/gamepad/mobile Noise Pulse action in situations where voice is optional for immersion. The monster still hears world noises (footsteps, doors, tools, machines) irrespective of voice choice. A microphone does NOT confer gameplay advantage and must never be mandatory for progression.

Explicit notice: 'With Mic-Reactive Danger on, the game uses your microphone loudness to create noise events that the creature can investigate. Voice audio is handled by Roblox. We do not record, save or transmit raw audio or speech transcripts to our own servers. Turn this off any time.' Verify the final technical implementation matches this text before shipping.

## Audio pipeline, implementation proposal
Client creates/finds the local eligible AudioDeviceInput and connects via Wire to AudioAnalyzer without disrupting default voice routing. Only sample audio volume locally, e.g. 10 Hz; compute 1–2 second rolling ambient baseline, RMS floor plus configurable hysteresis, attack/release envelope, cap emitted events per second, and classify quiet/medium/loud with conservative thresholds calibrated in real sessions. Mute and IsReady/Active/eligibility/opt-in gate reading. Do not add AudioDeviceOutput for the analyzer path.

Client sends only an enum-like noise band or normalised volume bucket with a client timestamp over a RemoteEvent, at most about 4 reports/second; no waveforms, no audio, no free text. Server applies rate limit, clamps bands, requires opted-in and voice eligibility state, verifies the player position is the server's own character position, and generates a bounded hearing event. Client-side measurement cannot be cryptographically trusted; exploiters can silence or spoof it. Monster remains fun/fair if no mic events arrive. Never rely on reported volume as a security-sensitive guarantee.

Server combines built-in AUTHORITY events (moving/running across material, doors, machines, tools, dropped decoys) with eligible optional mic reports into a finite-lived noise blackboard (position, type, effective power, createdAt, expiry, owner). Avoid exposing another player's mic data to clients. Hearing attenuates by radius, doors and room graph; update player acoustics at bounded intervals, not per physics step. AI prioritises credible sounds within a perception budget; server owns attack/aggro state.

## Speaking to the creature (optional phase, not MVP requirement)
Use Roblox AudioSpeechToText only when the player opts into a deliberate push-to-speak moment; recognise a small, clearly documented whitelist of short phrases such as 'Hello?', 'Are you there?', 'Stay away', or station call signs. On client, map locally recognised text to one enum intent and send only that intent; discard raw transcribed text immediately. Check STT caps and supported language/access before relying on it. Server validates state, range, intent, cooldown. The Return reacts with an authored positional line or mechanical pattern, NEVER genuinely paraphrases players or reproduces player voices. Non-voice interaction offers exactly the same branch via diegetic radio interaction. Do not promise uncensored conversational AI or real-time live human voice mimicry.

Roblox STT docs currently report a global request budget proportional to concurrent users, so do NOT run STT continuously for all players. STT is a stretch upgrade after microphone-volume investigation works robustly.

## Fairness and safety
- No mic required for escape, achievements, puzzles or any ending; captions and visual oscilloscopes supply equal information.
- Mic levels account for fans/speakers and have local calibration, a slider, noise gate, and hysteresis; avoid punishing silent noisy hardware.
- One accidental mic event is investigation, never instant certain attack. Provide readable cause (e.g. nearby answering relay).
- Nobody can toggle another player's mic mode; do not impersonate or transmit recognised speech.
- All remotes have server-side type/rate/bounds checks. Position comes from server character only.
- Never retain microphone measurements as player data. If analytics are desired, use anonymous count of opt-ins / failure modes only, after disclosure and policy review.
- Respect Roblox age/voice eligibility, group permissions, user mute controls and regional restrictions. Never bypass Roblox's voice system.

## Verification gates
Gate A: real eligible account hears other voice as expected; opt-out makes mic events cease; local analyzer reads nonzero RmsLevel.
Gate B: whisper/speaking/shouting cause consistent differentiated *in-game* reaction at reasonable calibration; background fan does not trigger constantly.
Gate C: 2–4 users, one opted out; report sources map to correct positions; server authoritative navigation works.
Gate D: no-mic player, muted voice, ineligible account, mobile/gamepad and failed API all complete the same level.
Gate E: no raw audio/text in network packets, logs, DataStores or HttpService calls; server remote tampering tests pass.
Gate F: optional STT whitelist works within budget and has button-based exact equivalent.

Potential blocker: voice behavior cannot be fully verified via unit tests or an offline Rojo build. Real Roblox eligible accounts, Studio Team Test and a published private experience are required for complete validation. Do not mark 'working' on API plausibility alone.
