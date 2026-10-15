# Windows setup and foundation playtest

Issue #1 only. This is a code foundation, not a playable horror game. World, microphone, menus and assets belong to later issues. Use a disposable private test place until the owner approves integration.

## Install

1. Install Git for Windows from https://git-scm.com/downloads/win and Roblox Studio from https://create.roblox.com/ . Open Studio and sign in once.
2. Download `rojo-7.7.1-windows-x86_64.zip` from https://github.com/rojo-rbx/rojo/releases/tag/v7.7.1 (ARM Windows: use the aarch64 archive). Extract `rojo.exe` to a tools directory and add that directory to your user PATH. Open a new PowerShell terminal.
3. Run `rojo --version`; expect `Rojo 7.7.1`. Run `rojo plugin install`, then restart Studio. Use the matching 7.7.1 plugin; do not enable two Rojo plugins. Alternatively install `Rojo.rbxm` from the same release in Studio's Plugins Folder. The VS Code extension alone does not add the CLI to PATH.
4. Optional: Rokit can install the pinned CLI using this repository's `rokit.toml` and `rokit install`. It is not required if you installed the release binary.

```powershell
git clone https://github.com/Cyberspectraa/RobloxHorrorGame.git
cd RobloxHorrorGame
git switch feat/1-project-foundation
powershell -NoProfile -File tools/Validate-Project.ps1 -Build
rojo serve default.project.json
```

If PowerShell policy blocks the checked-in validator, inspect the file first and use a process-only invocation: `powershell -NoProfile -ExecutionPolicy Bypass -File tools/Validate-Project.ps1 -Build`. Do not change machine-wide policy.

The validator performs structural assertions; `-Build` also runs actual Rojo builds and creates `build/TheRelayBelow.rbxlx`, `build/FoundationTests.rbxlx` and a sourcemap. It exits on any build failure. Run from any folder using the script's full path, or from the repository as above.

## Sync safely

Open a new **Baseplate** in Studio for the bootstrap playtest, so characters have somewhere to stand. This is a disposable test fixture, not proposed game art. Open Rojo's plugin, connect to `localhost:34872`, review the diff, then sync. Keep `rojo serve` running while editing source. The server binds to localhost only.

Source ownership:

| Studio location | Source | Editing rule |
| --- | --- | --- |
| ReplicatedStorage/Shared | src/shared | Edit files; Studio-only children here may be removed on sync |
| ServerScriptService/Server | src/server | Edit files; never put world assets here |
| StarterPlayer/StarterPlayerScripts/Client | src/client | Edit files; one client bootstrap |
| Workspace and siblings outside those three folders | Studio | Preserved by the production project |

Rojo does not export Studio edits back into these source files. Avoid duplicate bootstrap scripts outside the mapped folders. Stop Play before syncing code and restart Play for a clean require cache. Never sync the test project into the production place. No place ID is invented; after creating the private place, record its actual ID and add `servePlaceIds` to the production project in a reviewed commit to restrict accidental sync.

Opening the generated production rbxlx verifies source packaging, but it intentionally has no floor/map. Use Baseplate + sync for walking/spawn tests. A compiled source place is not a backup of future Studio-authored world assets.

## Solo startup and failure checks

1. Open Output and Script Analysis. Press Play (F5), not just Run, to create a client.
2. Expect one server `Server boot` INFO line with `state=Lobby` and `playable=false`, and one `Client boot` INFO line per client. These are expected messages, **not captured evidence**. No ERROR lines or Script Analysis errors should remain.
3. Stop and restart three times; reset the character. Confirm no duplicated boot and normal default spawn/respawn. Foundation adds no custom spawn or camera logic.
4. In a disposable copy with Rojo disconnected, remove `ReplicatedStorage/Shared` before Play: both bootstraps must report a bounded bootstrap failure instead of hanging or reporting success. Restore it by resyncing. Test a missing Config or Logger similarly.
5. Capture actual Output and Script Analysis results, Studio version, Rojo CLI/plugin version and commit SHA. If warnings/errors appear, include them rather than trimming evidence to only success lines.

## Lifecycle harness and multiplayer

Open `build/FoundationTests.rbxlx` separately. This isolated project maps only server foundation modules, shared modules and test code. Run it in Studio; expect `[FoundationTests] PASS` lifecycle checks. In Studio's Server & Clients test mode launch two clients, close one, then add/rejoin a client if supported by the Studio test controls. Each live membership change must produce a passing membership check and no error. Stop the session, then repeat. This test verifies actual Players events; the CLI state test cannot.

Repeat two-client startup in the normal Baseplate + production sync place. Each client should boot once, and the server should boot once. Neither client has a remote for state/progression. A client cannot require ServerScriptService modules. Leave/rejoin and character resets must not duplicate startup or leave stale tracked members. The default character loader remains Roblox-owned.

## CLI behavior tests

Download the optional official Luau 0.742 Windows binaries from https://github.com/luau-lang/luau/releases/tag/0.742 and add their directory to PATH. There are no runtime package dependencies.

```powershell
luau tests/state.spec.luau
luau-analyze src/server/Foundation/StateMachine.luau tests/state.spec.luau
Get-ChildItem src,tests -Recurse -Filter *.luau | ForEach-Object {
    luau-compile --binary $_.FullName > $null
    if ($LASTEXITCODE -ne 0) { throw "Compilation failed: $($_.FullName)" }
}
```

CI repeats these checks on Linux with the same pinned tool releases. Standalone analysis covers the pure state module and its test only; Roblox-aware type analysis must also be checked in Studio. Compilation is syntax verification, not Roblox API/runtime verification.

## Publish a private test place (manual)

After successful Studio checks, use File > Publish to Roblox for the disposable foundation place. Keep the experience **Private**, check its permissions in Creator Dashboard, and record the experience/place IDs and URL in the PR. Launch with the owner account on desktop and collect Output/log evidence where available. Do not enable microphone APIs, monetization, public access or external HTTP for this task. Publishing was not performed by this implementation session.

M1 remains pending until actual Studio/private desktop results are supplied, reviewed and merged. See [verification record](FOUNDATION_VERIFICATION.md).

Primary references checked during implementation: https://rojo.space/docs/v7/getting-started/installation/ , https://rojo.space/docs/v7/project-format/ , https://create.roblox.com/docs/reference/engine/classes/Players .
