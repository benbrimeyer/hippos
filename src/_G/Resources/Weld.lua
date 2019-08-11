local Instancenew = Instance.new

function Weld(Part1, Part0, Offset)
	local Joint 	= Instancenew("Weld")
	Joint.Part0 	= Part0
	Joint.Part1 	= Part1
	Joint.Parent = Part0
	
	if Offset then
		Joint.C0	= Offset
	elseif Part1 and Part0 then
		Joint.C0	= Part0.CFrame:inverse()*Part1.CFrame
	end
	
	return Joint
end

return Weld