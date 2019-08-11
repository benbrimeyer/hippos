local Instancenew = Instance.new

function WeldModel(Model, Center, OccludedInstances)
	local Welds = {}
	local Last = Center;
	
	local function Weld(Mod, OccludedInstances)
		for _, Object in pairs(Mod:GetChildren()) do
			if not OccludedInstances or not OccludedInstances[Object] then
				if Object:IsA("BasePart") and Object ~= Center then
					if Last then
						local Weld 	= Instancenew("Weld")
						Weld.Part0 	= Last
						Weld.Part1 	= Object
						Weld.C0			= Last.CFrame:inverse() * Object.CFrame
						Weld.Parent = Object
						if not Center then
							Last = Object
						end
					elseif not Last then
						Last = Object
					end
				else
					Weld(Object, OccludedInstances)
				end
			end
		end
	end
	
	Weld(Model, OccludedInstances)
	
	return Welds
end

return WeldModel