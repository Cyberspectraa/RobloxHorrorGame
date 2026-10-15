--!strict
-- Separate test.project.json only. Never mapped by default.project.json.
local RunService = game:GetService("RunService")
assert(RunService:IsStudio(), "Foundation tests must only run in Studio")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService = require(ServerScriptService.Foundation.PlayerService)
local service = PlayerService.new()
local checks = 0
local function expect(condition: boolean, message: string)
    assert(condition, message)
    checks += 1
end

local ok, failure = xpcall(function()
    service.stop()
    expect(service.getCount() == 0, "stop before start")
    service.start()
    expect(service.getCount() == #Players:GetPlayers(), "captures existing players")
    service.start()
    expect(service.getCount() == #Players:GetPlayers(), "duplicate start is harmless")
    for _, player in Players:GetPlayers() do
        expect(service.contains(player), "tracks existing player")
    end
    service.stop()
    expect(service.getCount() == 0, "stop clears tracked references")
    service.stop()
    expect(service.getCount() == 0, "duplicate stop is harmless")
    service.start()
    expect(service.getCount() == #Players:GetPlayers(), "restart captures current players")
end, debug.traceback)
if not ok then
    service.stop()
    error(failure)
end
print(string.format("[FoundationTests] PASS: %d lifecycle checks", checks))

-- Deferred checks run after all lifecycle listeners and engine membership updates.
local connections: { RBXScriptConnection } = {}
local function checkMembership()
    task.defer(function()
        assert(service.getCount() == #Players:GetPlayers(), "join/leave count mismatch")
        for _, player in Players:GetPlayers() do
            assert(service.contains(player), "joined player not tracked")
        end
        print("[FoundationTests] PASS: live join/leave membership")
    end)
end
table.insert(connections, Players.PlayerAdded:Connect(checkMembership))
table.insert(connections, Players.PlayerRemoving:Connect(checkMembership))
game:BindToClose(function()
    for _, connection in connections do connection:Disconnect() end
    service.stop()
end)
