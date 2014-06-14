local _P = ...
local string = require'string'

function _P.copy(dest,buffer,n)
	local rest = n
	local part = nil
	while rest>0 do
		if (#(buffer.buf))>rest then
			part = string.sub(buffer.buf,1,rest)
			buffer.buf = string.sub(buffer.buf,rest+1)
			rest = 0
			dest:write(part)
		else
			rest = rest - #(buffer.buf)
			dest:write(buffer.buf)
			buffer.buf = ''
			buffer:more()
		end
		if buffer.eof then break end
	end
	return n-rest
end

