local Instancenew = Instance.new

function EasyWeldModel(Model, Center)
	local Welds = {}
	local Last = Center;
	
	local function Weld(Mod, OccludedInstances)
		for _, Object in pairs(Mod:GetChildren()) do
			if not OccludedInstances or not OccludedInstances[Object] then
				if Object:IsA("BasePart") and Object ~= Center then
					if Last then
						local Weld 	= Instancenew("WeldConstraint")
						Weld.Part0 	= Last
						Weld.Part1 	= Object
						Weld.Parent = Object
						Object.Anchored = false
						
						if not Center then
							Last = Object
						end
					elseif not Last then
						Last = Object
					end
				elseif Object:IsA("Model") then
					Weld(Object, OccludedInstances)
				end
			end
		end
	end
	
	Weld(Model)
	
	return Welds
end

return EasyWeldModel