--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local cleanup: (() -> ())? = nil

local function boot()
    local shared = ReplicatedStorage:WaitForChild("Shared", 10)
    assert(shared, "ReplicatedStorage.Shared missing; check Rojo sync")
    local Config = require(shared.Config)
    local BuildInfo = require(shared.BuildInfo)
    local log = require(shared.Logger).new("Server", Config.DebugLogging)
    local state = require(script.Parent.Foundation.StateMachine).new()
    local players = require(script.Parent.Foundation.PlayerService).new()

    local stopped = false
    cleanup = function()
        if stopped then return end
        stopped = true
        players.stop()
        state.transition("Shutdown")
        log.info("Server stopped")
    end
    game:BindToClose(function()
        if cleanup then cleanup() end
    end)

    players.start()
    local transitioned, reason = state.transition("Lobby")
    assert(transitioned, reason)
    log.info("Server boot", string.format("phase=%s | state=%s | players=%d | playable=%s",
        BuildInfo.DevelopmentPhase, state.getState(), players.getCount(), tostring(BuildInfo.IsPlayable)))
    -- Lobby is a lifecycle state only. No round, world or automatic gameplay yet.
end

local ok, failure = xpcall(boot, debug.traceback)
if not ok then
    if cleanup then cleanup() end
    warn("[The Relay Below][Server][ERROR] Bootstrap failed | " .. tostring(failure))
end
