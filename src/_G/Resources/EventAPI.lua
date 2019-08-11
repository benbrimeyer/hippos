--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local EventClass = {};

function EventClass.Destroy(Event)
	Event.Parent[Event] = nil
end

function EventClass.Disconnect(Event)
	Event.Parent[Event] = nil
end

function AddEventAPI(Table)
	
	local Events = {};
	
	function Table:AddEvent(Event, Function, WorldInstance)
		
		--Make an event id array if one doesn't exist
		if not Events[Event] then
			Events[Event] = {}
		end
		
		local EventConnection = {};
		
		setmetatable(EventConnection, {__index = 
			function(_, Index)
				if Index == "Events" then
					return Events
				elseif Index == "Parent" then
					return Events[Event]
				else
					return EventClass[Index]
				end
			end
			})
		
		Events[Event][EventConnection] = Function
		
		--tie the connection to WorldInstance so if it gets destroyed the event auto-removes
		if WorldInstance then
			WorldInstance:GetPropertyChangedSignal("Parent"):connect(function()
				if not WorldInstance.Parent then
					EventConnection:Destroy()
				end
			end)
		end
		
		return EventConnection
	end
	
	function Table:FireEvent(Event, ...)
		for Id, Function in pairs(Events[Event] or {}) do
			local Args = {...}
			coroutine.resume(coroutine.create(function() Function(unpack(Args)) end))
		end
	end
end

return AddEventAPI