-- // Variables // --
 
local trans = script:WaitForChild("ERTMS_REPLICATED")
local board = script:WaitForChild("control_board")
local route = game.Workspace.tracks
local pos = route.PositionTransmitter
local yield = route.yielding
local locomotiveDriveSeat1 = game.Workspace["A1CS Stock Spawner"].Station["A1CR-Stock 2 car"]["Pullman Standard R46"].Car4.Body.Main
local locomotiveDriveSeat2 = game.Workspace["A1CS Stock Spawner"].Station["A1CR-Stock 2 car"]["Pullman Standard R46"].Front.Body
local module1 = locomotiveDriveSeat1.Drive.ERTMS_MODULE1
local module2 = locomotiveDriveSeat2.Drive.ERTMS_MODULE2
local controlTower = script:WaitForChild("Closest Locomotive | Distance:  studs.")

-- // settings, level 1 ERTMS // -- 

board.level1.ImposeSpeedLimit.Value = true -- set this to turn on speed limiting on the rails
board.level1.ImposeDirection.Value = true -- set this to turn on direction limiting on the rails
board.level1.ImposePassing.Value = true -- set this to turn on passing limiting on the rails
board.level1.ImposeRoute.Value = true -- set this to turn on route limiting on the rails
board.level1.ImposeOpposite.Value = true -- set this to turn on opposite platform limiting on the rails
board.level1.ImposeYield.Value = true -- set this to turn on yielding on the rails

board.level1.TrackLocomotives.Value = true -- Would you want to track locomotives on the tracks to warn other locomotives?

-- // settings, level 2 ERTMS // -- 

board.level2.MixedSignaling.Value = false -- again, wouldnt recommend enabling as it is a beta feature
board.level2.SendRunawayAlerts.Value = true -- send runaway train alerts to all locomotives on the network?

-- // DO NOT TOUCH BELOW // --

-- Check if all level1 has been false, if it has then make it true

if board.level1.ImposeSpeedLimit.Value == false and board.level1.ImposeDirection.Value == false and board.level1.ImposePassing.Value == false and board.level1.ImposeRoute.Value == false and board.level1.ImposeOpposite.Value == false and board.level1.ImposeYield.Value == false then
	board.level1.ImposeSpeedLimit.Value = true
	board.level1.ImposeDirection.Value = true
	board.level1.ImposePassing.Value = true
	board.level1.ImposeRoute.Value = true
	board.level1.ImposeYield.Value = true 
	board.level1.StopAllTrainsIncomingAndOutgoing.Value = true
end

-- Checks if level2 has been enabled, if it has then display onto the controlTower all level2 has been enabled

if board.level2.MixedSignaling.Value == true then
	controlTower.Value = "Mixed Signaling Enabled | Level 2 ERTMS"
else
	controlTower.Value = "Mixed Signaling Disabled | Level 1 ERTMS"
end

-- Connects both module1 and module2 using transmitter RemoteEvent to this script

module1.Transmitter.OnServerEvent:Connect(function(player, data)
	trans:FireClient(player, data)
end)

module2.Transmitter.OnServerEvent:Connect(function(player, data)
	trans:FireClient(player, data)
end)

trans.OnServerEvent:Connect(function(player, data)
	if data.event == "board_update" then
		board.level1.SpeedLimit.Value = data.speed_limit
		board.level1.Direction.Value = data.direction
		board.level1.Passing.Value = data.passing
		board.level1.Route.Value = data.route
		board.level1.Opposite.Value = data.opposite
		board.level1.Yield.Value = data.yield
		board.level1.SpeedLimit.Value = data.speed_limit
	end
end)

pos.OnServerEvent:Connect(function(player, data)
	if data.event == "locomotive_position" then
		pos.locomotive_position.Value = data.locomotive_position
	end
end)


-- it shares the module1 and module2 data to be displayed on the controlTower using transmitter RemoteEvent from this script to be displayed on controlTower

module1.OnServerEvent:Connect(function(player, data)
	if data.event == "board_update" then
		controlTower.board.level1.SpeedLimit.Value = data.speed_limit
		controlTower.board.level1.Direction.Value = data.direction
		controlTower.board.level1.Passing.Value = data.passing
		controlTower.board.level1.Route.Value = data.route
		controlTower.board.level1.Opposite.Value = data.opposite
		controlTower.board.level1.Yield.Value = data.speed_limit
	end
end)
