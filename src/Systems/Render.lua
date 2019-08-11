local World = _G.GetResource("World")

local newSystem = World.System:extend(script.Name)

local cache = {}
local function getCache(entity, model)
	if not cache[model] then
		cache[model] = {}
	end

	local old = cache[model][entity]
	if not old then
		local new = model:Clone()
		new.Parent = game:GetService("Workspace")
		cache[model][entity] = new
	end

	return cache[model][entity]
end

function newSystem:step(t, dt)
	for entity, transform, sprite in World.core:components("Transform", "Sprite") do
		local primitive = getCache(entity, sprite.model)

		primitive.Position = transform.position
		primitive.Size = transform.size
	end
end

return newSystem