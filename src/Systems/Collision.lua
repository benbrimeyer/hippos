local World = _G.GetResource("World")
local Raycast = _G.GetResource("RaycastWithEvaluator")

--[[
	Raycast(Origin, Direction, Distance, Ignore, IgnoreWater, Evaluator)
]]
local newSystem = World.System:extend(script.Name)
local ballRadius = 1

function newSystem:step(t, dt)
	for entity, canCollide, transform in World.core:components("CanCollide", "Transform") do
		local entityPos = transform.position

		for targetEntity, targetCanCollide, targetTransform in World.core:components("CanCollide", "Transform") do
			local targetEntityPos = targetTransform.position
			local difference = (entityPos-targetEntityPos)
			local distance = difference.magnitude
			local direction = difference.unit

			if distance <= ballRadius then
				local pushBack = ballRadius-(distance/2)
				
				local entityWallHit, entityWallPos, entityWallNormal = Raycast(entityPos, direction, pushBack, {}, true, function(hit)
					if hit:IsDescendantOf(workspace.Map) then
						return true
					else
						return false
					end
				end)

				local targetEntityWallHit, targetEntityWallPos, targetEntityWallNormal = Raycast(targetEntityPos, -direction, pushBack, {}, true, function(hit)
					if hit:IsDescendantOf(workspace.Map) then
						return true
					else
						return false
					end
				end)

				if entityWallPos then
					transform.position = entityWallPos + (entityWallNormal * ballRadius)
				else
					--transform.position = entityPos + (direction * pushBack)
				end

				if targetEntityWallPos then
					targetTransform.position = targetEntityWallPos + (targetEntityWallNormal * ballRadius)
				else
					--targetTransform.position = targetEntityPos + (-direction * pushBack)
				end
			end
		end
	end
end

return newSystem