--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildInfo = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("BuildInfo"))

print(string.format("[The Relay Below] Server boot: %s | phase=%s | playable=%s",
    BuildInfo.DesignVersion,
    BuildInfo.DevelopmentPhase,
    tostring(BuildInfo.IsPlayable)
))
-- Foundation placeholder intentionally contains no gameplay claims.
-- See docs/PRODUCTION_PLAN.md before implementing RoundService.
