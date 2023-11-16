-- Sets autocommands for output buffer and output window management. Applies 
-- default settings and applies any user customizations.

local M = {}

-- TODO: Provide startup customization options
local default_settings = {
    auto_start = false,

    -- Window will be aligned horizontally if this value is false
    vertical = true
}
M.current = default_settings

M.set = function(opts)
    M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), opts)
end

-- Closes the output window if it is the last open window
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("", { clear = true }),
    callback = function()
        local win_count = vim.fn.winnr("$")
        local win_bufnr = vim.fn.winbufnr("#")
        if win_count == 1 and win_bufnr == vim.g.output_bufnr then
            vim.cmd("bdelete! | q")
        end
    end
})

-- Resets the output buffer number when its corresponding buffer is deleted 
vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("DeleteOutputBuffer", { clear = true }),
    callback = function()
        local win_bufnr = vim.fn.winbufnr("#")
        if win_bufnr == vim.g.output_bufnr then
            vim.cmd("bdelete!")
            vim.g.output_bufnr = nil
        end
    end
})

return M

