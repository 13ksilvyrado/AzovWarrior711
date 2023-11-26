player = game:GetService("Players"):GetPlayerFromCharacter(script.Parent)
character = player.Character:WaitForChild("Head").Parent 

player.Chatted:Connect(function(msg)
	if string.lower(msg) == "only in ohio" then 
		character.Humanoid.Health = 0
	end
end)
