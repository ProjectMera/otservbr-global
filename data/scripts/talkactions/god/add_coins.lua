local add_coins = TalkAction("/addcoins")

function add_coins.onSay(player, words, param)
    local split = param:split(" ")
    local target = Player(split[1])
    if not target then
        return player:sendCancelMessage("This player does not exist.")
    end
    local amount = tonumber(split[2])
    if type(amount) ~= 'number' then
        player:sendCancelMessage("Not a valid integer!")
        return false
    end
		if amount > 25000 then
        player:sendCancelMessage("Amount cannot exceed 25000!")
        return false
    end
		local accountId = getAccountNumberByPlayerName(target)
    if accountId == 0 then
        return false
    end
    local result = db.query('UPDATE accounts SET coins = coins+'.. amount ..' WHERE id = ' .. accountId)
    if result then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You gave " .. amount .. " tibia coins.")
        target:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. amount .. " tibia coins.")
    end
return true
end

add_coins:separator(" ")
add_coins:register()

