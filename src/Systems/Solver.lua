local World = _G.GetResource("World")

local newSystem = World.System:extend(script.Name)

function newSystem:step(t, dt)
	for entity, transform, motion in World.core:components("Transform", "Motion") do
		--TODO:
	end
end

return newSystem