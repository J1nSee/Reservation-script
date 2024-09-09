local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "bot_data")

local itemCode = "" -- 아이템 코드를 넣도록 해 
local itemCode1 = "" -- 아이템 코드를 넣도록 해 

MySQL.createCommand("vRP/Get_FetchData", "SELECT * FROM bot_data WHERE discord_id = @discord_id")
MySQL.createCommand("vRP/Remove_Data", "DELETE FROM bot_data WHERE discord_id = @discord_id")

RegisterServerEvent("bot_data:Sex")
AddEventHandler("bot_data:Sex", function()
    local source = source
    local user_id = vRP.getUserId({source})
    --local discord_id = GetDiscordIdentifier(source)
    local discord_id = ""
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord_id = "".. v:gsub("discord:", "") ..""
        end
    end
    if (discord_id ~= nil) then
        MySQL.query("vRP/Get_FetchData", {discord_id = discord_id}, function(rows, affected)
            if (#rows == 1) then
                MySQL.query("vRP/Remove_Data", {discord_id = discord_id})
                vRPclient.notify(source, {"[테스트]\n 사전 예약 보상이 지급되었습니다."})
                vRP.giveInventoryItem({user_id, itemCode, 1, true})
                vRP.giveInventoryItem({user_id, itemCode1, 1, true})
            else
                vRPclient.notify(source, {"[테스트]\n 지급 대상자가 아닙니다."})
            end
        end)
    else
        vRPclient.notify(source, {"[테스트]\n 보상 획득을 위해 디스코드와 파이브엠을 연동해주세요."})
    end
end)
