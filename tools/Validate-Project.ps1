[CmdletBinding()]
param([switch]$Build)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$project = Get-Content -LiteralPath (Join-Path $root 'default.project.json') -Raw | ConvertFrom-Json
function Check([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
    Write-Output "PASS: $Message"
}
Check ($project.tree.'$className' -eq 'DataModel') 'Root is DataModel'
Check ($project.serveAddress -eq '127.0.0.1') 'Sync binds to localhost'
$mappings = @(
    @($project.tree.ReplicatedStorage.Shared, 'src/shared'),
    @($project.tree.ServerScriptService.Server, 'src/server'),
    @($project.tree.StarterPlayer.StarterPlayerScripts.Client, 'src/client')
)
foreach ($mapping in $mappings) {
    Check ($mapping[0].'$path' -eq $mapping[1]) "Mapping $($mapping[1])"
    Check (Test-Path -LiteralPath (Join-Path $root $mapping[1]) -PathType Container) "Directory $($mapping[1]) exists"
    Check ($mapping[0].'$ignoreUnknownInstances' -eq $false) "Source folder $($mapping[1]) is owned by Rojo"
}
foreach ($node in @($project.tree, $project.tree.ReplicatedStorage, $project.tree.ServerScriptService, $project.tree.StarterPlayer, $project.tree.StarterPlayer.StarterPlayerScripts)) {
    Check ($node.'$ignoreUnknownInstances' -eq $true) 'Studio-owned siblings are preserved'
}
$scripts = @(Get-ChildItem -LiteralPath (Join-Path $root 'src') -Filter '*.luau' -Recurse)
Check ($scripts.Count -gt 0) 'Luau source exists'
foreach ($file in $scripts) {
    Check ((Get-Content -LiteralPath $file.FullName -TotalCount 1) -eq '--!strict') "Strict directive: $($file.Name)"
}
Check (@($scripts | Where-Object Name -Like '*.server.luau').Count -eq 1) 'Exactly one server entry point'
Check (@($scripts | Where-Object Name -Like '*.client.luau').Count -eq 1) 'Exactly one client entry point'
Check ($project.tree.PSObject.Properties.Name -notcontains 'Workspace') 'Production project does not own world geometry'
Write-Output 'Structural checks passed. This is not Rojo schema validation or a Luau/runtime test.'
if ($Build) {
    $null = Get-Command rojo -ErrorAction Stop
    Push-Location $root
    try {
        New-Item -ItemType Directory -Path build -Force | Out-Null
        & rojo --version
        if ($LASTEXITCODE -ne 0) { throw 'Rojo version check failed' }
        & rojo build default.project.json -o build/TheRelayBelow.rbxlx
        if ($LASTEXITCODE -ne 0) { throw 'Production Rojo build failed' }
        & rojo sourcemap default.project.json -o build/sourcemap.json
        if ($LASTEXITCODE -ne 0) { throw 'Rojo sourcemap failed' }
        & rojo build test.project.json -o build/FoundationTests.rbxlx
        if ($LASTEXITCODE -ne 0) { throw 'Studio test Rojo build failed' }
    } finally { Pop-Location }
}
