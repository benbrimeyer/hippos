function Reflect(inDirection, inNormal)
	local num = -2 * inNormal:Dot(inDirection)
	inNormal = inNormal * num
	inNormal = inNormal + inDirection
	return inNormal
end

return Reflect