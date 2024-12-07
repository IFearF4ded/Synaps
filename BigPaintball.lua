while task.wait(1) do
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    local localTeam = localPlayer.Team

    if localCharacter and localCharacter:FindFirstChild("HumanoidRootPart") then
        local localCFrame = localCharacter.HumanoidRootPart.CFrame
        local offset = localCFrame.LookVector * 5

        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Team ~= localTeam then
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character:SetPrimaryPartCFrame(localCFrame + offset)

                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Anchored = true
                        end
                    end
                end
            end
        end
    end
end
