local CoinDistribute = GlobalEvent("Coin Distribute")

function CoinDistribute.onThink(interval)
	local players = Game.getPlayers()
	if next(players) == nil then
		return true;
	end
	local amount = tonumber(1)
	for _, targetPlayer in ipairs(players) do
		if targetPlayer ~= nil then
			local accountId = getAccountNumberByPlayerName(targetPlayer)
			if accountId ~= 0 then 
				local result = db.query('UPDATE accounts SET coins = coins+'.. amount ..' WHERE id = ' .. accountId)
				if result then
					targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. amount .. " Mera coins.")
				end
			end
		end
	end
	return true
end

CoinDistribute:interval(1000 * 60 * 15) -- 15 minute interval
CoinDistribute:register()
