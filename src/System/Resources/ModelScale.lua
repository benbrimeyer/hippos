local ModelScale = {}

function ModelScale:ScaleModel(Model, Scale, DontUseOriginSize)
	if not Model then
		return
	end
	
	if not Model.PrimaryPart:FindFirstChild("Scale") then
		local OriginScale = Instance.new("Vector3Value", Model.PrimaryPart)
		OriginScale.Name = "Scale"
		OriginScale.Value = Vector3.new(1,1,1)
	end
	
	Model.PrimaryPart.Scale.Value = Scale
	
	for _, Object in pairs(Model:GetDescendants()) do
		if Object:IsA("DataModelMesh") then
			if not DontUseOriginSize and not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Scale
				OriginSize.Name = "OriginalSize"
			end
			
			local Offset = Object.Parent.Position-Model.PrimaryPart.Position
			local OffsetOffset = (Offset * Scale)-Offset
			
			if not DontUseOriginSize then
				Object.Scale = Object.OriginalSize.Value*Scale
			else
				Object.Scale = Object.Scale*Scale
			end
			
			Object.Offset = OffsetOffset
			
		elseif Object:IsA("BasePart") and Object.Transparency ~= 1 and not Object:FindFirstChildOfClass("SpecialMesh") and not Object:FindFirstChildOfClass("BlockMesh") then
			
			if not DontUseOriginSize and not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Size
				OriginSize.Name = "OriginalSize"
				
				local OriginOffset = Instance.new("CFrameValue", Object)
				OriginOffset.Value = Model.PrimaryPart.CFrame:inverse()*Object.CFrame
				OriginOffset.Name = "OriginOffset"
			end
			
			if not DontUseOriginSize then
				local Offset = Object.OriginOffset.Value
				
				Object.Size = Object.OriginalSize.Value * Scale;
				Object.CFrame = Model.PrimaryPart.CFrame * (Offset-Offset.p) * CFrame.new(Offset.p*Scale) 
			else
				local Offset = Model.PrimaryPart.CFrame:inverse()*Object.CFrame
				
				Object.Size = Object.Size * Scale;
				Object.CFrame = Model.PrimaryPart.CFrame * (Offset-Offset.p) * CFrame.new(Offset.p*Scale) 
			end
		end
	end
end


function ModelScale:TweenModelScale(Model, Scale, Time, EasingDirection, EasingStyle)
	local TweenService = game:GetService("TweenService")
	
	if not Model.PrimaryPart:FindFirstChild("Scale") then
		local OriginScale = Instance.new("Vector3Value", Model.PrimaryPart)
		OriginScale.Name = "Scale"
		OriginScale.Value = Vector3.new(1,1,1)
	end
	
	Model.PrimaryPart.Scale.Value = Scale
	
	for _, Object in pairs(Model:GetDescendants()) do
		
		--Mesh
		if Object:IsA("DataModelMesh") then
			if not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Scale
				OriginSize.Name = "OriginalSize"
			end
			
			local Offset = Object.Parent.Position-Model.PrimaryPart.Position
			local OffsetOffset = (Offset * Scale)-Offset
			
			TweenService:Create(
				Object,
				TweenInfo.new(Time, Enum.EasingStyle[EasingStyle], Enum.EasingDirection[EasingDirection]),
				
				{
					Scale = Object.OriginalSize.Value * Scale;
					Offset = OffsetOffset
				}
			):Play()
			
		--BasePart
		elseif Object:IsA("BasePart") and Object.Transparency ~= 1 and not Object:FindFirstChildOfClass("SpecialMesh") and not Object:FindFirstChildOfClass("BlockMesh") then
			
			if not Object:FindFirstChild("OriginalSize") then
				local OriginSize = Instance.new("Vector3Value", Object)
				OriginSize.Value = Object.Size
				OriginSize.Name = "OriginalSize"
				
				local OriginOffset = Instance.new("CFrameValue", Object)
				OriginOffset.Value = Object.CFrame*Model.PrimaryPart.CFrame:inverse()
				OriginOffset.Name = "OriginOffset"
			end
			
			local Offset = Object.OriginOffset.Value
			
			TweenService:Create(
				Object,
				TweenInfo.new(Time, Enum.EasingStyle[EasingStyle], Enum.EasingDirection[EasingDirection]),
				
				{
					Size = Object.OriginalSize.Value * Scale;
					CFrame = Model.PrimaryPart.CFrame * (Offset-Offset.p) * CFrame.new(Offset.p*Scale) ;
				}
			):Play()
		end
		
	end
end

return ModelScale