function ScaleModel(Model, Scale, Center, DontScaleAttachments)
	local Center = Center or Model.PrimaryPart
	
	if not Center:FindFirstChild("Scale") then
		local OriginScale = Instance.new("Vector3Value", Center)
		OriginScale.Name = "Scale"
		OriginScale.Value = Vector3.new(1,1,1)
	end
	
	Center.Scale.Value = Scale
	
	for _, Object in pairs(Model:GetDescendants()) do
		if Object:IsA("BasePart") and not Object:FindFirstChildOfClass("SpecialMesh") then
			if not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Size
				OriginSize.Name = "OriginalSize"
				
				local OriginalPosition = Instance.new("Vector3Value", Object)
				OriginalPosition.Value = Object.Position-Center.Position
				OriginalPosition.Name = "OriginalOffset"
			end
			
			local Offset = Object.OriginalOffset.Value
			Object.Size = Object.OriginalSize.Value * Scale
			Object.CFrame = CFrame.new(Center.Position+(Offset*Scale)) * (Object.CFrame-Object.CFrame.p) --Scaled position with object rotation
			
		elseif Object:IsA("SpecialMesh") then
			if not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Scale
				OriginSize.Name = "OriginalSize"
			end
			
			local Offset = Object.Parent.Position-Model.PrimaryPart.Position
			Object.Scale = Object.OriginalSize.Value * Scale
			Object.Offset = Vector3.new(Offset*Scale)
			
		elseif Object:IsA("Attachment") and not DontScaleAttachments then
			if not Object:FindFirstChild("OriginalPosition") then
				local OriginalPosition = Instance.new("Vector3Value", Object)
				OriginalPosition.Value = Object.Position
				OriginalPosition.Name = "OriginalPosition"
			end
			
			Object.Position = Object.OriginalPosition.Value * Scale
		elseif Object:IsA("Motor6D") then
			Object:Destroy()
		end
	end
	
	require(script.Parent.WeldModel)(Model, Center)
end

return ScaleModel