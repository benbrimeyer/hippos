local World = _G.GetResource("World")

return World.defineComponent(script.Name, function()
	return {
		position = Vector3.new(),
		size = Vector3.new(),
	}
end)