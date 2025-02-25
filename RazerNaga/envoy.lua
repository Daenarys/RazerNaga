--[[
	EnvoyProto
		A simple message passing object.
--]]

local assert = function(condition, msg)
	if not condition then
		return error(msg, 3)
	end
end

--ye old constructor
local EnvoyProto = {}
local EnvoyProto_MT = {__index = EnvoyProto}

function EnvoyProto:New(obj)
	local o = setmetatable(obj or {}, EnvoyProto_MT)
	o.listeners = {}
	return o
end


--trigger a message, with the given args
function EnvoyProto:Send(msg, ...)
	assert(msg, 'Usage: EnvoyProto:Send(msg[, args])')
	assert(type(msg) == 'string', 'String expected for <msg>, got: \'' .. type(msg) .. '\'')

	local listeners = self.listeners[msg]
	if listeners then
		for obj, action in pairs(listeners) do
			action(obj, msg, ...)
		end
	end
end


--tells obj to do something when msg happens
function EnvoyProto:Register(obj, msg, method)
	assert(obj and msg, 'Usage: EnvoyProto:Register(obj, msg[, method])')
	assert(type(msg) == 'string', 'String expected for <msg>, got: \'' .. type(msg) .. '\'')

	local method = method or msg
	local action

	if type(method) == 'string' then
		assert(obj[method] and type(obj[method]) == 'function', 'Object does not have an instance of ' .. method)
		action = obj[method]
	else
		assert(type(method) == 'function', 'String or function expected for <method>, got: \'' .. type(method) .. '\'')
		action = method
	end

	local listeners = self.listeners[msg] or {}
	listeners[obj] = action
	self.listeners[msg] = listeners

--	assert(self.listeners[msg] and self.listeners[msg][obj], 'EnvoyProto: Failed to register ' .. msg)
end

function EnvoyProto:RegisterMany(obj, ...)
	assert(obj and select('#', ...) > 0, 'Usage: EnvoyProto:RegisterMany(obj, msg, [...])')
	for i = 1, select('#', ...) do
		self:Register(obj, (select(i, ...)))
	end
end


--tells obj to do nothing when msg happens
function EnvoyProto:Unregister(obj, msg)
	assert(obj and msg, 'Usage: EnvoyProto:Unregister(obj, msg)')
	assert(type(msg) == 'string', 'String expected for <msg>, got: \'' .. type(msg) .. '\'')

	local listeners = self.listeners[msg]
	if listeners then
		listeners[obj] = nil
		if not next(listeners) then
			self.listeners[msg] = nil
		end
	end

--	assert(not(self.listeners[msg] and self.listeners[msg][obj]), 'EnvoyProto: Failed to ignore ' .. msg)
end


--ignore all messages for obj
function EnvoyProto:UnregisterAll(obj)
	assert(obj, 'Usage: EnvoyProto:UnregisterAll(obj)')

	for msg in pairs(self.listeners) do
		self:Unregister(obj, msg)
	end
end


--create a RazerNaga specific instance of envy
RazerNaga.Envoy = EnvoyProto:New()