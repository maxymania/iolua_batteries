local _P = ...
local string = require'string'

local function readline(buffer)
	local data,rest
	while true do
		data,rest = string.match(buffer.buf,"^([^\r\n]*)\r?\n(.*)$")
		if data or buffer.eof then break end
		buffer:more()
	end
	if not data then return nil end
	buffer.buf=rest
	return data
end

function _P.parseRequest(buffer)
	local request,line,k,v,ack
	request = {
		hdrt = {},
		header = {},
		command = '',
		url = '',
		version = ''
	}
	line = readline(buffer)
	request.command,
	request.url,
	request.version=
	string.match(line,'^([^ ]+) ([^ ]+) HTTP/(1[.][10])')
	line = readline(buffer)
	k = nil
	while line and #line>0 do
		if k then
			ack = v
			request.hdrt[k]=string.lower(k)
			v = string.match(line,'^[ \t]+(.*)$')
			while v do
				ack = ack..v
				line = readline(buffer)
				if not (line and #line>0) then break end
				v = string.match(line,'^[ \t]+(.*)$')
			end
			request.header[string.lower(k)]=ack
			if not (line and #line>0) then k = nil; break end
		end
		k,v = string.match(line,'^([a-zA-Z0-9_-]+)[ \t]-:[ \t]+(.*)')
		line = readline(buffer)
	end
	if k then
		request.hdrt[k]=string.lower(k)
		request.header[string.lower(k)]=v
	end
	return request
end

