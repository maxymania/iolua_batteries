local string = require'string'
local table = require'table'
local modules = require'$rt.modules'
local loaders = require'$rt.loaders'
local inc = {}
modules['$inc']=inc
table.insert(loaders,function(modname)
	local i,j,k,l
	k=string.gsub(modname,'[.]','/')
	for i,j in ipairs(inc) do
		l = nil
		try(function() l = loadfile(j..k..'.lua') end)
		if l then
			j = {}
			modules[modname] = j
			l(j)
			return
		end
	end
end)

