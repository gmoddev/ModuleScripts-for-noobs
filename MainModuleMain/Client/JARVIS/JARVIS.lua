-- module script goes in LocalScript
local J = {}
local runss = game:GetService("RunService")
local content = game:GetService("ContentProvider")
local ignored = {}
local resource = false -- Temp

function J.done()
	warn("JARVIS: FINISHED PRELOAD")
	
	wait()
	script.Parent:Destroy()
end

function J.Load()
	if runss:IsServer() then
		warn("JARVIS IS MENT FOR CLIENTSIDE, THINGS MAY BREAK!")
		return
	else
		print("Starting JARVIS")
		for i,service in pairs(game:GetChildren()) do
			pcall(function()
				if not ignored[service.Name] then
					print("JARVIS: LOADING ".. service.Name)
					wait(.2)
					content:PreloadAsync(service)
					wait()
				end
			end)
		end

		local function checkreq()
			print("JARVIS: CHECKING REQ SIZE")
			if content.RequestQueueSize > 0 then
				print("JARVIS: PRELOAD QUEUE NOT FINISHED")
				wait(0.1)
				print("JARVIS: CHECKING QUEUE SIZE")
				checkreq()
			else
				warn("JARVIS: QUEUE SIZE FINISHED...")
				print("JARVIS: CHECKING FOR EXTRA RESOURCES.")
				wait(.5)
				print("JARVIS: CHECKING FOR EXTRA RESOURCES..")
				wait(.5)
				print("JARVIS: CHECKING FOR EXTRA RESOURCES..")
				wait(.5)
				if resource then
					print("JARVIS: FOUND EXTRA RESOURCES")
					wait(.5)
					print("JARVIS: LOADING EXTRA RESOURCES.")
					wait(1)
					print("JARVIS: LOADING EXTRA RESOURCES..")
					wait(1)
					print("JARVIS: LOADING EXTRA RESOURCES...")
					J.done()
				else
					print("JARVIS: NO EXTRA RESOURCES FOUND")
					wait(.5)
					J.done()
				end
			end
		end
		checkreq()
		
	end
end

return J
