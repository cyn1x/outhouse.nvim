local layout = require("outhouse.layout")
local settings = require("outhouse.settings")

local M = {}

-- Entry point for the calling function
M.setup = function(args)
    if args then
        settings.set(args)
    end

    if settings.current.auto_start then
        layout.create_output_buffer()
    end
end

return M

