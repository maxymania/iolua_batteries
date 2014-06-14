local _P = ...
local string = require'string'
local tab = {a='-A',b='-B',c='-C',d='-D',e='-E',f='-F',h='-H',i='-I',j='-J',
k='-K',l='-L',m='-M',n='-N',o='-O',p='-P',q='-Q',r='-R',s='-S',t='-T',u='-U',
v='-V',w='-W',x='-X',y='-Y',z='-Z'}

function _P.writeResponse(dest,code,codedescr,headers,body)
	dest:write(string.format('%d %s HTTP/1.1\r\n',code,codedescr))
	headers['content-length']=tostring(#body)
	for k,v in pairs(headers) do
		if v then
			dest:write(
				string.sub(string.gsub('-'..k,'[-]([a-z])',tab),2)..': '..
				v..'\r\n'
			)
		end
	end
	dest:write('\r\n')
	dest:write(body)
end

