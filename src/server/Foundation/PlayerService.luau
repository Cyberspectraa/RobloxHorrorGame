--!strict
local Players = game:GetService("Players")

local PlayerService = {}

function PlayerService.new()
    local active = false
    local tracked: { [Player]: boolean } = {}
    local connections: { RBXScriptConnection } = {}
    local count = 0

    local function add(player: Player)
        -- No yields between membership check and insertion.
        if not active or player.Parent ~= Players or tracked[player] then return end
        tracked[player] = true
        count += 1
    end

    local function remove(player: Player)
        if not tracked[player] then return end
        tracked[player] = nil
        count -= 1
    end

    local function stop()
        active = false
        for _, connection in connections do connection:Disconnect() end
        table.clear(connections)
        table.clear(tracked)
        count = 0
    end

    return table.freeze({
        start = function()
            if active then return end
            active = true
            -- Subscribe first: join events and the initial snapshot may overlap.
            table.insert(connections, Players.PlayerAdded:Connect(add))
            table.insert(connections, Players.PlayerRemoving:Connect(remove))
            for _, player in Players:GetPlayers() do add(player) end
        end,
        stop = stop,
        getCount = function(): number
            return count
        end,
        contains = function(player: Player): boolean
            return tracked[player] == true
        end,
    })
end

return table.freeze(PlayerService)
