local plrz = game:GetService("Players")
local cliente = Players.LocalPlayer
local clientemouse = cliente:GetMouse()
local clicks = 0

clientemouse.MouseButton1Down:Connect(function))
  clicks_counter += 1 
end)

while task.wait(1) do 
  if clicks_counter >= 20 then
      cliente:Kick("Auto clicker detected!")
  end
  clicks_counter = 0
end -- lmk if this shit dont work frfr
