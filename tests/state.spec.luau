--!strict
local StateMachine = require("../src/server/Foundation/StateMachine")

local checks = 0
local function expect(value: boolean, message: string)
    assert(value, message)
    checks += 1
end

local state = StateMachine.new()
expect(state.getState() == "Booting", "initial state")
local ok = state.transition("Gameplay")
expect(not ok and state.getState() == "Booting", "cannot skip initialization")
expect(state.transition("Lobby"), "boot to lobby")
expect(not state.transition("Lobby"), "duplicate transition rejected")
expect(not state.transition("Ending"), "cannot skip gameplay")
expect(state.transition("Gameplay"), "start gameplay")
expect(state.transition("Lobby"), "abort to lobby")
expect(state.transition("Gameplay"), "restart gameplay")
expect(state.transition("Ending"), "reach ending")
expect(state.transition("Lobby"), "return from ending")
expect(not state.transition("Bogus" :: any), "runtime invalid state rejected")
expect(state.getState() == "Lobby", "rejection preserves current state")
local other = StateMachine.new()
expect(other.getState() == "Booting", "instances are independent")
expect(state.transition("Shutdown"), "shutdown from lobby")
expect(not state.transition("Lobby"), "shutdown is terminal")
expect(not state.transition("Shutdown"), "duplicate shutdown rejected")
expect(other.transition("Shutdown"), "shutdown during boot")
for _, target in { "Gameplay", "Ending" } do
    local machine = StateMachine.new()
    assert(machine.transition("Lobby"))
    assert(machine.transition("Gameplay"))
    if target == "Ending" then assert(machine.transition("Ending")) end
    expect(machine.transition("Shutdown"), "shutdown from " .. target)
end
print(string.format("PASS: %d state machine checks", checks))
