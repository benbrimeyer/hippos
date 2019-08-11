local Raynew = Ray.new
local TableInsert = table.insert
local Workspace = game.Workspace

function Raycast(Origin, Direction, Ignore, IgnoreWater, IgnoreHitFunction)
	local Cast = Raynew(Origin, Direction)
	local Ignore = Ignore or {}
	
	while true do
		local Hit, Position, Normal, Material = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore, false, not IgnoreWater)
		
		if Hit and Hit:FindFirstChild("Hole") then
			return false, Direction
		end
		
		if Hit and (Hit.CanCollide or (IgnoreHitFunction and not IgnoreHitFunction(Hit))) then
			return Hit, Position, Normal, Material
			
		elseif Hit and not Hit.CanCollide then
			TableInsert(Ignore, Hit)
			
		elseif not Hit then
			return Hit, Position, Normal, Material
			
		end
	end
end

return Raycast