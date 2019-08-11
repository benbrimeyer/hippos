local TweeningSystem 	= {}
local TweenData 		= {}
local Camera			= game.Workspace.CurrentCamera
local CurrentID			= 0;

local Color3new 	= Color3.new
local CFrameNew 	= CFrame.new
local GetTime 		= tick
local MathMin 		= math.min
local RunService	= game:GetService("RunService")

local function IsEmpty(Tab)
	for _,_ in pairs(Tab) do
		return false
	end
	
	return true
end

local function lerpAngle(a, b, c)
	local a = a % (math.pi * 2)
	local b = b % (math.pi * 2)
	
	if (b - a) > math.pi then
		b = b - math.pi * 2
	elseif (b - a) < -math.pi then
		b = b + math.pi * 2
	end
	
	return a + (b - a) * c
end

local CurrentId = 0;

function TweeningSystem:TweenObjectProperty(Object, Type, Property, Value, Time, Scale, EasingStyle)
	CurrentId = CurrentId + 1
	
	local Id = CurrentId
	local Scale = Scale or 0
	
	if TweenData[Object] and TweenData[Object][Property] then
		TweeningSystem:StopTweening(Object, Property)
	end
	
	if not TweenData[Object] then
		TweenData[Object] = {}
	end
	
	local Start;
	
	if Type == "NumberSequence" then
		Start = 0
	else
		Start 		= 
			(Type ~= "Minutes" and Type ~= "ModelCFrame" and Type ~= "ModelToPartCFrame" and Type ~= "ModelSize" and Type ~= "ModelScale" and Type ~= "PartCFrame" and Object[Property]) 
			or 
			(Type ~= "ModelCFrame" and Type ~= "ModelToPartCFrame" and Type ~= "PartCFrame" and Type ~= "ModelSize" and Type ~= "ModelScale" and Object:GetMinutesAfterMidnight())
	end
	
	local CurrentTime 	= GetTime()
	local PercentDone 	= 0
	local Connection;
		
	if Type == "Color3" then
		local EndRed, EndGreen, EndBlue = Value.r, Value.g, Value.b
		local StartRed, StartGreen, StartBlue = Start.r, Start.g, Start.b
		
		Connection = RunService.Heartbeat:connect(function()
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object[Property] = Color3new(
				StartRed 	* (1-PercentDone) + (EndRed 	*	PercentDone),
				StartGreen 	* (1-PercentDone) + (EndGreen 	*	PercentDone),
				StartBlue  	* (1-PercentDone) + (EndBlue 	*	PercentDone)
			)
			
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
			end
		end)
		
	elseif Type == "Number" then
		
		Connection = RunService.Heartbeat:connect(function()
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object[Property] = (Start * (1-PercentDone)) + (Value * PercentDone)
			
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
				return
			end
		end)
		
	elseif Type == "NumberSequence" then
		
		Connection = RunService.Heartbeat:connect(function()
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			Object[Property] = NumberSequence.new(Start * (1-PercentDone) + (Value * PercentDone))
			
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
				return
			end
		end)
		
	elseif Type == "Vector3" then
		local Lerp = Start.lerp
		local LastUpdate = GetTime();
		
		Connection = {}
		
		function Connection:Disconnect()
			RunService:UnbindFromRenderStep("Tween"..Id)
		end
		
		RunService:BindToRenderStep("Tween"..Id, Enum.RenderPriority.Character.Value-1, function()
			if tick()-LastUpdate < Scale then
				return
			end
			
			LastUpdate = GetTime();
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object[Property] = Lerp(Start, Value, PercentDone)
				
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
			end
		end)
		
	elseif Type == "CFrame" then
		local CurrentTime 	= GetTime();
		local PercentDone 	= 0
		local Lerp = Start.lerp
		local LastUpdate = GetTime();

		Connection = RunService.Heartbeat:connect(function()
			if tick()-LastUpdate < Scale then
				return
			end
			
			LastUpdate = GetTime();
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object[Property] = Lerp(Start, Value, PercentDone)
			
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
			end
		end)
		
	elseif Type == "ModelCFrame" then
			if not Object.PrimaryPart then
				return
			end
			
			local Start 		= Object.PrimaryPart.CFrame
			local CurrentTime 	= GetTime();
			local PercentDone 	= 0
			local UpdateRate 	= 0
			local LastUpdate 	= 0
			local SetPrimaryPartCFrame = Object.SetPrimaryPartCFrame
			local Lerp = Start.lerp
			
			Connection = RunService.Heartbeat:connect(function()
				LastUpdate = GetTime()
				
				if Object.PrimaryPart then
					PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
					SetPrimaryPartCFrame(Object, Lerp(Start, Value, PercentDone))				
				else
					TweeningSystem:StopTweening(Object, Property)
				end
				
				if PercentDone == 1 then						
					TweeningSystem:StopTweening(Object, Property)
				end
			end)
			
	elseif Type == "ModelToPartCFrame" then
		if not Object.PrimaryPart then
			return
		end
		
		local Start 		= Object.PrimaryPart.CFrame
		local CurrentTime 	= GetTime();
		local PercentDone 	= 0
		local UpdateRate 	= 0
		local LastUpdate 	= 0
		local SetPrimaryPartCFrame = Object.SetPrimaryPartCFrame
		local Lerp = Start.lerp

		Connection = RunService.Heartbeat:connect(function()
			if GetTime()-LastUpdate >= UpdateRate then
				LastUpdate = GetTime()
				
				if Object.PrimaryPart then
					PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
					SetPrimaryPartCFrame(Object, Lerp(Start, Value.CFrame, PercentDone))				
				else
					TweeningSystem:StopTweening(Object, Property)
				end
				
				if PercentDone == 1 then						
					TweeningSystem:StopTweening(Object, Property)
				end
			end
		end)
		
	elseif Type == "PartCFrame" then
		local Start 		= Object.CFrame
		local CurrentTime 	= GetTime();
		local PercentDone 	= 0
		local UpdateRate 	= 0
		local LastUpdate 	= 0
		local Lerp 			= Start.lerp

		Connection = RunService.Heartbeat:connect(function()
			if GetTime()-LastUpdate >= UpdateRate then
				LastUpdate = GetTime()
				
				PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
				Object.CFrame = Lerp(Start, Value.CFrame, PercentDone)		
				
				if PercentDone == 1 then						
					TweeningSystem:StopTweening(Object, Property)
				end
			end
		end)
			
	elseif Type == "ModelSize" then
		if not Object.PrimaryPart then
			return
		end
		
		local CurrentTime 	= GetTime();
		local PercentDone 	= 0
		local UpdateRate 	= 0
		local LastUpdate 	= 0
		local SetPrimaryPartCFrame = Object.SetPrimaryPartCFrame
		local Starts = {};
		
		for _, v in pairs(Object:GetChildren()) do
			if v:IsA("BasePart") then
				Starts[v] = v.Size
			end
		end

		Connection = RunService.Heartbeat:connect(function()
			if GetTime()-LastUpdate >= UpdateRate then
				LastUpdate = GetTime()
				
				--Stop if there's a primary part
				if Object.PrimaryPart then
					PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
					
					for Part, OriginalSize in pairs(Starts) do
						Part.Size = OriginalSize:lerp(OriginalSize*Value, PercentDone)
					end
				else
					TweeningSystem:StopTweening(Object, Property)
				end
				
				if PercentDone == 1 then						
					TweeningSystem:StopTweening(Object, Property)
				end
			end
		end)
		
	elseif Type == "Minutes" then
		
		Connection = RunService.Heartbeat:connect(function()
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object:SetMinutesAfterMidnight((Start * (1-PercentDone)) + (Value * PercentDone))
			
			if PercentDone == 1 then
				TweeningSystem:StopTweening(Object, Property)
			end
		end)
		
	elseif Type == "Angle" then
		local LastUpdate = GetTime();
		
		Connection = {}
		
		function Connection:Disconnect()
			RunService:UnbindFromRenderStep("Tween"..Id)
		end
		
		RunService:BindToRenderStep("Tween"..Id, Enum.RenderPriority.Character.Value-1, function()
			if tick()-LastUpdate < Scale then
				return
			end
			
			LastUpdate = GetTime();
			
			PercentDone = MathMin((GetTime()-CurrentTime)/Time, 1)
			
			Object[Property] = lerpAngle(Start, Value, PercentDone)
			
			if PercentDone == 1 and TweenData[Object][Property] == Connection then
				TweeningSystem:StopTweening(Object, Property)
			end
		end)
	end
	
	TweenData[Object][Property] = Connection
end


function TweeningSystem:StopTweening(Object, Property)
	local ObjectTweenData = TweenData[Object]
	
	if not ObjectTweenData then
		return
	end
	
	if ObjectTweenData and ObjectTweenData[Property] then
		ObjectTweenData[Property]:Disconnect()
		ObjectTweenData[Property] = nil
	end
	
	if IsEmpty(ObjectTweenData) then
		TweenData[Object] = nil
	end
end


return TweeningSystem