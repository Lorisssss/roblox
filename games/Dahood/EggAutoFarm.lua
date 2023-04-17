local eggsFolder = game:GetService("Workspace").Ignored

local eggCount = 0

for _, egg in pairs(eggsFolder:GetChildren()) do
    if egg:IsA("MeshPart") and egg.Name:find("Egg") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
        wait(1)
        eggCount += 1
    end
end

if eggCount == 0 then
    print("no more eggs")
end
