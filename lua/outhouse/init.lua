local layout = require("outhouse.layout")
local settings = require("outhouse.settings")

local M = {}

-- Entry point for the calling function
M.setup = function(args)
    if args then
        settings.set(args)
    end

    layout.createOutputBuffer()
end

return M

