local AnimationId 	= 0;
local RunService	= game:GetService("RunService")

function CreateAnimation(ImageObject, Rows, Columns, TotalCells, Speed, Looped)
	AnimationId = AnimationId + 1;
	
	local AnimationInfo = {
		Id 		= AnimationId;
		
		Speed 	= Speed;
		Looped 	= Looped;
		Playing = false;
	};
	
	function AnimationInfo:Play()
		if AnimationInfo.Playing then
			return
		end
		
		local Row 			= 1;
		local Column 		= 1;
		local CountedCells 	= 1;
		
		local Last		= tick();
		
		RunService:BindToRenderStep("SpriteAnimation"..AnimationId, 0, function()
			if tick()-Last < Speed then
				return
			end
			
			Last = tick();
			
			if ImageObject then
				
				ImageObject.ImageRectOffset = Vector2.new(ImageObject.ImageRectSize.X*(Column-1), ImageObject.ImageRectSize.Y*(Row-1))
				
				CountedCells = CountedCells + 1;
				Column = Column + 1;
				
				--If the next column doesnt exist move down a row
				if Column > Columns then
					Column 	= 1;
					Row 	= Row + 1;
				end
				
				if Row > Rows  or CountedCells > TotalCells then
					--Completed Animation
					
					if not AnimationInfo.Looped then
						AnimationInfo:Stop()
						return
					else
						CountedCells =1;
						Column = 1;
						Row = 1;
					end
				end
			else
				AnimationInfo:Stop()
				return
			end
		end)
		
	end
	
	function AnimationInfo:Stop()
		RunService:UnbindFromRenderStep("SpriteAnimation")
		AnimationInfo.Playing = false
	end
	
	return AnimationInfo
end

return CreateAnimation