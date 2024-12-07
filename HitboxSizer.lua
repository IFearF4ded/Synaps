local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")

local applyToAll = false

local function modifyHumanoidRootPart(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(40, 40, 40)
        hrp.Transparency = 0.5
        hrp.BrickColor = BrickColor.new("Bright blue")
        hrp.CanCollide = false
    else
        warn("HumanoidRootPart not found in character")
    end
end

local function resetHumanoidRootPart(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 1
        hrp.BrickColor = BrickColor.new("Medium stone grey")
        hrp.CanCollide = true
    else
        warn("HumanoidRootPart not found in character")
    end
end

local function applyHitboxSize()
    local teamCount = #Teams:GetTeams()
    print("Number of teams: " .. teamCount)

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if applyToAll then
                    if player ~= Players.LocalPlayer then
                        modifyHumanoidRootPart(player.Character)
                    end
                else
                    if teamCount <= 1 then
                        modifyHumanoidRootPart(player.Character)
                    else
                        local localPlayerTeam = Players.LocalPlayer.Team
                        if player.Team == localPlayerTeam then
                            resetHumanoidRootPart(player.Character)
                        else
                            modifyHumanoidRootPart(player.Character)
                        end
                    end
                end
            end
        end
    end
end

local function onCharacterAdded(character)
    applyHitboxSize()
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then
        onCharacterAdded(player.Character)
    end
end

local function applyHitboxSizeToAllExceptLocal()
    applyToAll = not applyToAll
    applyHitboxSize()
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.O then
        applyHitboxSizeToAllExceptLocal()
    end
end)

while task.wait(3) do
    applyHitboxSize()
end
