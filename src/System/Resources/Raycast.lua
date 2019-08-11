local Raynew = Ray.new
local TableInsert = table.insert
local Workspace = game.Workspace

function Raycast(Origin, Direction, Distance, Ignore, IgnoreWater)
	local Cast = Raynew(Origin, Direction*Distance)
	local Ignore = Ignore or {}
	
	while true do
		local Hit, Position, Normal, Material = Workspace.FindPartOnRayWithIgnoreList(Workspace, Cast, Ignore, false, not IgnoreWater)
		
		if Hit and Hit:FindFirstChild("Hole") then
			return false, Direction*Distance
		end
		
		if 
			(Hit and Hit.Name ~= "HumanoidRootPart") and 
			
			(Hit.CanCollide or 
				(Hit.Parent and (Hit.Parent:FindFirstChild("Entity_Data") or Hit.Parent:FindFirstChildOfClass("Humanoid"))) or 
				(Hit.Name == "Water" and not IgnoreWater) 
			)
		then
			return Hit, Position, Normal, Material
			
		elseif Hit then
			TableInsert(Ignore, Hit)
			
		elseif not Hit then
			return Hit, Position, Normal, Material
			
		end
	end
end

return Raycast