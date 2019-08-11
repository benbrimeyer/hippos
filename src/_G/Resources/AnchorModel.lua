function AnchorModel(Model, Anchored)
	for Index, Object in pairs(Model:GetChildren()) do
		if Object:IsA("BasePart") then
			Object.Anchored = Anchored
		else
			AnchorModel(Object, Anchored)
		end
	end
end

return AnchorModel