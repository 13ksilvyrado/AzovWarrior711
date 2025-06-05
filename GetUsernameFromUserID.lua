function plr()
	plr = game:GetService("Players")
	local nameOne = plr:GetNameFromUserIdAsync(123456789) -- Uses Roblox Players Documentation
end
print("Name is;",	nameOne)
