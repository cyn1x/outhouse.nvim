-- Sets default visual layout

local M = {}

-- Open buffer for communicating with external processes and viewing their
-- output in real time.
M.createOutputBuffer = function()
    if not vim.g.output_bufnr then
        vim.cmd("rightb vnew")
        vim.cmd("setlocal nobuflisted")
        vim.g.output_bufnr = vim.api.nvim_get_current_buf()
    end
end

return M

