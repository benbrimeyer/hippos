local TweenService = game:GetService("TweenService")
local Tweens = {};

local TweenContainer = Instance.new("Folder", workspace)
TweenContainer.Name = "Tweens";

local function TableEmpty(Table)
	for _,_ in pairs(Table) do
		return false
	end
	
	return true
end

function WrapperTween(Object, Type, Property, Value, Time, EasingStyle, Direction)
	local TweenObject;
	local Tween;
	
	--Cancel existing tween
	if Tweens[Object] and Tweens[Object][Property] then
		Tweens[Object][Property]:Cancel()
	end
	
	if Type == "Number" then
		TweenObject = Instance.new("NumberValue", TweenContainer)
	elseif Type == "Vector3" then
		TweenObject = Instance.new("Vector3Value", TweenContainer)
	end
	
	TweenObject.Value = Object[Property]
	
	TweenObject:GetPropertyChangedSignal("Value"):connect(function()
		Object[Property] = TweenObject.Value
	end)
	
	local Tween = TweenService:Create(TweenObject, TweenInfo.new(Time, Enum.EasingStyle[(not EasingStyle and "Quad") or EasingStyle], Enum.EasingDirection[(not Direction and "Out") or Direction]), {Value = Value})
	
	if not Tweens[Object] then
		Tweens[Object] = {};
	end
	
	Tweens[Object][Property] = Tween
	
	Tween:Play()
	
	Tween.Completed:connect(function()
		TweenObject:Destroy()
		Tweens[Object][Property] = nil
		
		if TableEmpty(Tweens[Object]) then
			Tweens[Object] = nil
		end
	end)
	
	return Tween
end

return WrapperTween