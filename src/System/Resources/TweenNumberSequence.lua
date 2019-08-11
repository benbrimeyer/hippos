local TweenService = game:GetService("TweenService")

function TweenNumberSequence(Object, Property, Value, Time, EasingStyle, EasingDirection)
	
	local NumberValue = Instance.new("NumberValue", workspace.Effects)
	NumberValue.Name = ""
	NumberValue.Value = Object[Property].Keypoints[1].Value;
	
	local Tween = TweenService:Create(
		NumberValue,
		TweenInfo.new(Time or 1, Enum.EasingStyle[EasingStyle or "Quad"], Enum.EasingDirection[EasingDirection or "Out"]),
		{ Value = Value }
	)
	
	local UpdateSignal = NumberValue:GetPropertyChangedSignal("Value"):connect(function()
		Object[Property] = NumberSequence.new(NumberValue.Value, NumberValue.Value)
	end)
	
	Tween.Completed:connect(function()
		Tween:Destroy()
		UpdateSignal:Disconnect()
		NumberValue:Destroy()
	end)
	
	Tween:Play()
	
	return Tween
end

return TweenNumberSequence