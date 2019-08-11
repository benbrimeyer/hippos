--Used to resize a number sequence into studs or some other max size.

--Global variables
local max 							= math.max;
local NumberSequenceKeypoint_new 	= NumberSequenceKeypoint.new
local NumberSequence_new 			= NumberSequence.new

function ResizeNumberSequence(Sequence, MaxSize)
	local Keypoints = Sequence.Keypoints
	local Max = 0;
	
	for i, Keypoint in pairs(Keypoints) do
		Max = max(Max, Keypoint.Value)
	end
	
	local NewKeypoints = {};
	
	for i, Keypoint in pairs(Keypoints) do
		local Scale = (Keypoint.Value/Max)
		NewKeypoints[i] = NumberSequenceKeypoint_new( Keypoint.Time, Scale * MaxSize, (Keypoint.Envelope*Scale)*MaxSize )
	end
	
	return NumberSequence_new(NewKeypoints)
end

return ResizeNumberSequence