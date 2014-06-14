local _P = ...
local string = require'string'

local metatable = {__index={
	more = function(self)
		if self.eof then return end
		local d = self.fd:read(1024)
		if type(d)=='string' then
			self.buf = self.buf..d
		else
			self.eof=true
		end
	end
}}
local metatable2 = {__index={
	flush = function(self)
		if self.eof then return end
		local d = self.fd:write(self.buf)
		if type(d)~='number' then
			self.eof=true
		elseif d<=0 then
			self.eof=true
		else
			self.buf = string.sub(self.buf,d+1)
		end
	end,
	write = function(self,data)
		self.buf = self.buf..data
	end
}}

function _P.initBuffer(fd)
	local buf = {buf='',fd=fd,eof=false}
	setmetatable(buf,metatable)
	return buf
end

function _P.initWriter(fd)
	local buf = {buf='',fd=fd,eof=false}
	setmetatable(buf,metatable2)
	return buf
end

