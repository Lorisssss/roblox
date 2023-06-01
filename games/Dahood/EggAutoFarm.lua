-- // Put this in your autoexe

repeat
    wait()
until game:isloaded()
local teleportservice = game:getservice("teleportservice")
local httpservice = game:getservice("httpservice")

local eggsfolder = game:getservice('workspace').ignored
local eggcount = 0

local function findnewserver()
    local servers = {}
    local nextpagecursor
    while true do
        local url = string.format("https://games.roblox.com/v1/games/%d/servers/public?sortorder=asc&limit=100%s", game.placeid, nextpagecursor and "&cursor=" .. nextpagecursor or "")
        local response = httpservice:jsondecode(game:httpget(url))
        for _, server in ipairs(response.data) do
            if server.id ~= game.jobid and server.playing < server.maxplayers then
                return server.id
            end
            table.insert(servers, server)
        end
        nextpagecursor = response.nextpagecursor
        if not nextpagecursor then
            break
        end
    end
    return nil
end

local function serverhopper()
    local serverid = findnewserver()
    if serverid then
        teleportservice:teleporttoplaceinstance(game.placeid, serverid)
    end
end

while true do
    for _, egg in pairs(eggsfolder:getchildren()) do
        if egg:isa('meshpart') and egg.name:find('egg') then
            game.players.localplayer.character.humanoidrootpart.cframe = egg.cframe
            wait(1)
            eggcount = eggcount + 1
            rconsolewarn("picked up an egg!")
        end
    end
    if eggcount == 0 then
        rconsolewarn('no more eggs!')
        serverhopper()
    end
    eggcount = 0
    wait(1)
end
