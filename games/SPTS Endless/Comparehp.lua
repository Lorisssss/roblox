local Players = game:GetService("Players")
local MyPlayer = Players.LocalPlayer
local MyMaxHP = MyPlayer.Character:WaitForChild("Humanoid").MaxHP.value

for _, player in ipairs(Players:GetPlayers()) do
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			local MaxHP = humanoid.MaxHP.value
			local Message = player.Name .. "'s Max HP: " .. MaxHP
			if MaxHP > MyMaxHP then
				Message = Message .. "Stronger"
			elseif MaxHP < MyMaxHP then
				Message = Message .. "Weaker"
			end
			print(Message)
		end
	end
end
