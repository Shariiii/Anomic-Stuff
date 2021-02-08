if not _G.TeleportBypass then
	local player = game.Players.LocalPlayer
	local playerUI = player:WaitForChild("PlayerGui",100)
	local RS = game:GetService("ReplicatedStorage")
	local stupidRemote = RS:WaitForChild("_CS.Events",10):WaitForChild("ToolEvent",10)
	local logs = 0
	local busy = false
	local findAndDisableScript
	findAndDisableScript = function()
		busy = true
		local script = playerUI:WaitForChild("_L.Handler",15):WaitForChild("GunHandlerLocal",15)
		local script2 = playerUI:WaitForChild("_L.Handler",15):WaitForChild("CameraFixer",15)
		if script and script2 then
			script2.Disabled = true
			wait(0)
			script.Disabled = true
			script2.Parent = RS
			wait(0)
			script.Disabled = false
			script2.Disabled = false
			wait(0)
			if script.Parent == nil then
				script2:Destroy()
			else
				script2.Parent = script.Parent
			end
		end
		if logs > 0 then
			logs = logs - 1
			findAndDisableScript()
		end
		busy = false
	end
	findAndDisableScript()
	stupidRemote.OnClientEvent:Connect(function()
		if busy then
			logs = logs + 1
		else
			findAndDisableScript()
		end
	end)
	_G.TeleportBypass = true
end