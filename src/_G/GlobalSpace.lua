--[[
	NOTES

	-Resources are small helper modules
	-Systems are game-specific managers and usually intertwined
	-Services are generic standalone systems
	-Bins are containers for data (entities, characters, etc)
--]]
-----------------------------------
local GlobalSpace = {
	Resources 	= {};
	Systems 	= {};
	Services	= {};
	Classes		= {};
	Bins 		= {};
};
----------------------------------------
local Resources = GlobalSpace.Resources;
local Systems 	= GlobalSpace.Systems;
local Services 	= GlobalSpace.Services;
local Bins 		= GlobalSpace.Bins;
local Classes	= GlobalSpace.Classes;
----------------------------------------
_G.GetClass = function(classId)
	--print('Get system: ', systemId, Systems[systemId])
	return Classes[classId]
end

_G.RegisterClass = function(classId, class)
	if Systems[classId] then
		warn("Class: ", classId, " is already registered!")
		return
	end

	--print('registered system: ', systemId)
	Classes[classId] = class;
end
----------------------------------------
_G.GetSystem = function(systemId)
	--print('Get system: ', systemId, Systems[systemId])
	return Systems[systemId]
end

_G.RegisterSystem = function(systemId, system)
	if Systems[systemId] then
		warn("System: ", systemId, " is already registered!")
		return
	end

	--print('registered system: ', systemId)
	Systems[systemId] = system;
end
------
_G.GetResource = function(resourceId)
	return Resources[resourceId]
end

_G.RegisterResource = function(resourceId, resource)
	if Resources[resourceId] then
		warn("Resource: ", resourceId, " is already registered!")
		return
	end

	Resources[resourceId] = resource;
end
-----
_G.GetBin = function(resourceId)
	return Bins[resourceId]
end

_G.RegisterBin = function(binId, bin)
	if Bins[binId] then
		warn("Bin: ", binId, " is already registered!")
		return
	end

	Bins[binId] = bin;
end
-----
_G.GetService = function(serviceId)
	return Services[serviceId]
end

_G.RegisterService = function(serviceId, service)
	if Services[serviceId] then
		warn("Service: ", serviceId, " is already registered!")
		return
	end

	Services[serviceId] = service
end

_G.WrapService = function(serviceId, metaTable)
	if Services[serviceId] then
		warn("Service: ", serviceId, " is already wrapped!")
		return
	end

	Services[serviceId] = setmetatable(game:GetService(serviceId), {__index = metaTable})
end

_G.RegisterSystem("GlobalSpace", GlobalSpace)
----------------------------------------
--Initialize System->Resources modules
for _, Service in pairs(script.Parent.Resources:GetChildren()) do
	_G.RegisterResource(Service.Name, require(Service))
end
----------------------------------------
return GlobalSpace