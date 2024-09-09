local coords = {-2243.5339355469,286.58148193359,173.54809570312} -- 좌표

Citizen.CreateThread(function()
    while true do
        ready = 500
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local px, py, pz = playerPos.x, playerPos.y, playerPos.z

        if GetDistanceBetweenCoords(coords[1], coords[2], coords[3], px, py, pz, true) <= 30 then
            ready = 5
            if GetDistanceBetweenCoords(coords[1], coords[2], coords[3], px, py, pz, true) >= 3 then
                DrawTxt(coords[1], coords[2], coords[3] + 2.0, "[서버명]\n 사전예약 보상")
            end
            DrawMarker(1, coords[1], coords[2], coords[3], 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, 100, 149, 237, 200, 0, 0, 0, true)

            if GetDistanceBetweenCoords(coords[1], coords[2], coords[3], px, py, pz) < 1 then
                ready = 5
                DrawTxt(px, py, pz + 1.0, "[E] 키를 눌러주세요.")
                if (IsControlJustReleased(1, 51)) then
                    TriggerServerEvent("bot_data:Sex")
                end
            end
        end
        Citizen.Wait(ready)
    end
end)

-- 요고는 폰트 관련
readyfont = RegisterFontId("lostf")

function DrawTxt(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 50
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.3 * scale)
        SetTextFont(readyfont)
        SetTextProportional(1)
        SetTextColour(255, 172, 215, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
