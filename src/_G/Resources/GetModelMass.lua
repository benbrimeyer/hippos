function GetModelMass(Model)
	local Mass = 0;
	
	for _, v in pairs(Model:GetDescendants()) do
		if v:IsA("BasePart") then
			Mass = Mass + v:GetMass()
		end
	end
	
	return Mass
end

return GetModelMass