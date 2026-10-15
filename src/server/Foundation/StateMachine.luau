--!strict
-- This module lives only in ServerScriptService. No client transition API exists.
export type State = "Booting" | "Lobby" | "Gameplay" | "Ending" | "Shutdown"

local allowed: { [string]: { [string]: boolean } } = {
    Booting = { Lobby = true, Shutdown = true },
    Lobby = { Gameplay = true, Shutdown = true },
    Gameplay = { Ending = true, Lobby = true, Shutdown = true },
    Ending = { Lobby = true, Shutdown = true },
    Shutdown = {},
}

local StateMachine = {}

function StateMachine.new()
    local current: State = "Booting"
    return table.freeze({
        getState = function(): State
            return current
        end,
        transition = function(nextState: State): (boolean, string?)
            if allowed[current][nextState] ~= true then
                return false, string.format("Rejected transition %s -> %s", current, tostring(nextState))
            end
            current = nextState
            return true, nil
        end,
    })
end

return table.freeze(StateMachine)
