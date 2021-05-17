local timeOnline = 60 * 60 * 1000
local pointPlayers = {}

function addcoins_timed(PID, playerIP)
    local player = Player(PID)
    if player then
        db.query("UPDATE accounts SET coins = coins + 1 WHERE id = '" ..player:getAccountId().. "';")
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have been online for a sec :) and have earned 1 Store coin.")
        addEvent(addcoins_timed, 1000, PID, playerIP)
        return true
    else
        pointPlayers[playerIP] = nil
    end
end

function onLogin(player)
    local PID = player:getId()
    local playerIP = player:getIp()
  
    if not pointPlayers[player:getIp()]  then
        pointPlayers[playerIP] = true
        addEvent(addcoins_timed, 1000, PID, playerIP)
    end
    return true
end
