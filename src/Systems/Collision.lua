local World = _G.GetResource("World")

local newSystem = World.System:extend(script.Name)

function newSystem:step(t, dt)
	for entity, canCollide, transform in World.core:components("CanCollide", "Transform") do
		--TODO:
	end
end

return newSystem