local forwardV3 	= Vector3.new(0,0,-1)
local acos 			= math.acos
local fromAxisAngle = CFrame.fromAxisAngle

local function solveIK(originCF, targetPos, length1, length2) 
	local localized 	= originCF:pointToObjectSpace(targetPos).unit
	local axis 			= forwardV3:Cross(localized)
	
	local planeCF 		= originCF * fromAxisAngle(axis, acos(-localized.Z)) 
	local totalLength 	= (originCF.p - targetPos).magnitude
	
	if totalLength < (length1 + length2) then
		local length1Squared 		= length1 * length1
		local length2Squared 		= length2 * length2
		local planeLengthSquared 	= totalLength * totalLength
		
		local ratioFromOrigin 		= (-length2Squared + length1Squared + planeLengthSquared) / (2 * length1 * totalLength)
		local ratioFromArm 			= (length2Squared - length1Squared + planeLengthSquared) / (2 * length2 * totalLength)
		
		local angleFromOrigin 		= -acos(ratioFromOrigin)
		local angleFromArm 			= acos(ratioFromArm) - angleFromOrigin
		
		return planeCF, angleFromOrigin, angleFromArm
	else
		return planeCF, 0, 0
	end
end

return solveIK