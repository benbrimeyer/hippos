function calculateBestThrowSpeed(origin, target, timeToTarget, gravity)
	
     -- calculate vectors
     local toTarget 	= target - origin;
     local toTargetXZ = toTarget;
     toTargetXZ = toTargetXZ*Vector3.new(1,0,1);
     
     -- calculate xz and y
     local y = toTarget.y;
     local xz = toTargetXZ.magnitude;
     
     -- calculate starting speeds for xz and y. Physics forumulase deltaX = v0 * t + 1/2 * a * t * t
     -- where a is "-gravity" but only on the y plane, and a is 0 in xz plane.
     -- so xz = v0xz * t => v0xz = xz / t
     -- and y = v0y * t - 1/2 * gravity * t * t => v0y * t = y + 1/2 * gravity * t * t => v0y = y / t + 1/2 * gravity * t
     local t = timeToTarget;
     local v0y = y / t + 0.5 * gravity * t;
     local v0xz = xz / t;
     
     -- create result vector for calculated starting speeds
     local result = toTargetXZ.unit;        -- get direction of xz but with magnitude 1
     result = result*v0xz;                                -- set magnitude of xz to v0xz (starting speed in xz plane)
     result = Vector3.new(result.x, v0y, result.z);                                -- set y to v0y (starting speed of y plane)
     
     return result;
end

return calculateBestThrowSpeed