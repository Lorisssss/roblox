-- // Put this in your autoexe

repeat
    wait()
until game:IsLoaded()
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local eggsFolder = game:GetService('Workspace').Ignored
local eggCount = 0

local function findNewServer()
    local servers = {}
    local nextPageCursor
    while true do
        local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100%s", game.PlaceId, nextPageCursor and "&cursor=" .. nextPageCursor or "")
        local response = HttpService:JSONDecode(game:HttpGet(url))
        for _, server in ipairs(response.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                return server.id
            end
            table.insert(servers, server)
        end
        nextPageCursor = response.nextPageCursor
        if not nextPageCursor then
            break
        end
    end
    return nil
end

local function serverHopper()
    local serverId = findNewServer()
    if serverId then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId)
    end
end

while true do
    for _, egg in pairs(eggsFolder:GetChildren()) do
        if egg:IsA('MeshPart') and egg.Name:find('Egg') then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
            wait(1)
            eggCount += 1
            rconsolewarn("Picked up an egg!")
        end
    end
    if eggCount == 0 then
        rconsolewarn('No more eggs!')
        serverHopper()
    end
    eggCount = 0
    wait(1)
end
