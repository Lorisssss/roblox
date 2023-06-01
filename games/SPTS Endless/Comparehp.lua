local players = game:getservice("players")
local myplayer = players.localplayer
local myMaxHP = myplayer.character:WaitForChild("humanoid").maxhp.value

for _, player in ipairs(players:getplayers()) do
	local character = player.character
	if character then
		local humanoid = character:findfirstchild("humanoid")
		if humanoid then
			local maxhp = humanoid.maxhp.value
			local message = player.name .. "'s max hp: " .. maxhp
			if maxhp > maxhp then
				message = message .. "Stronger"
			elseif maxhp < maxhp then
				message = message .. "Weaker"
			end
			print(message)
		end
	end
end
