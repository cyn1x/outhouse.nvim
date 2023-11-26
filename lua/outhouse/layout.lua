local settings = require('outhouse.settings')

local M = {}

-- Sets default visual layout
-- Open buffer for communicating with external processes and viewing their
-- output in real time.
M.create_output_buffer = function()
    if not vim.g.output_bufnr then
        if settings.current.vertical then
            vim.cmd("rightb vnew")
        else
            vim.cmd("bel new")
        end
        vim.cmd("setlocal nobuflisted")
        vim.g.output_bufnr = vim.api.nvim_get_current_buf()
    end
end

return M

