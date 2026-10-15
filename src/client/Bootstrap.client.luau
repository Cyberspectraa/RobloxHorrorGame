--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildInfo = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("BuildInfo"))
print(string.format("[The Relay Below] Client boot | %s | no gameplay yet", BuildInfo.GameTitle))
-- Client presentation and microphone opt-in are tracked as separate work packets.
