local CoinEvent = GlobalEvent("Coin Event")
function CoinEvent.onStartup()
	return true
end

CoinEvent:register()

local CoinDistribute = GlobalEvent("Coin Distribute")
function CoinDistribute.onThink(interval)
	local players = Game.getPlayers()
	local amount = tonumber(1)
	for _, targetPlayer in ipairs(players) do
		local accountId = getAccountNumberByPlayerName(targetPlayer)
    if accountId == 0 then
        return true
    end
    local result = db.query('UPDATE accounts SET coins = coins+'.. amount ..' WHERE id = ' .. accountId)
    if result then
        targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. amount .. " Mera coins.")
    end
	return true
	end
	end

CoinDistribute:interval(1000 * 60 * 60) -- 1 Hour interval
CoinDistribute:register()
