local World = _G.GetResource("World")

return World.defineComponent(script.Name, function()
	return {
		acceleration = Vector3.new(),
		velocity = Vector3.new(),
	}
end)