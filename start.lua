#!/usr/bin/env iolua

-- this is an example

-- first, we need to load the loader.
loadfile'loader.lua'()

-- than we need to insert our module path into the $inc variable, defined by
-- the loader.
require'table'.insert(require'$inc','./batteries/')

-- now we can load our batterie modules
local buffer = require'servers.buffer'
local bufload = require'servers.bufload'
-- ....
