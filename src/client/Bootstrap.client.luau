--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function boot()
    -- Replication order is not guaranteed. Bound every dependency wait.
    local shared = ReplicatedStorage:WaitForChild("Shared", 10)
    assert(shared, "ReplicatedStorage.Shared missing; check Rojo sync")
    local function module(name: string, timeout: number): ModuleScript
        local child = shared:WaitForChild(name, timeout)
        assert(child and child:IsA("ModuleScript"), "Missing shared module: " .. name)
        return child :: ModuleScript
    end
    local Config = require(module("Config", 10))
    local BuildInfo = require(module("BuildInfo", Config.ModuleWaitSeconds))
    local log = require(module("Logger", Config.ModuleWaitSeconds)).new("Client", Config.DebugLogging)
    log.info("Client boot", BuildInfo.GameTitle .. " | no gameplay yet")
    -- No polling, remotes, microphone access, UI or progression decisions.
end

local ok, failure = xpcall(boot, debug.traceback)
if not ok then
    warn("[The Relay Below][Client][ERROR] Bootstrap failed | " .. tostring(failure))
end
