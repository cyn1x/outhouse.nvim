local layout = require('outhouse.layout')

local M = {}

-- Requests user input if there is no filepath given
local validate_path = function(path)
    if path == nil then
        local input = vim.fn.input('Filepath: ')
        return input
    else
        return path
    end
end

-- Writes subprocess output to the output buffer
M.subprocess = function(path)
    local append = false
    local on_event = function(id, data, event)
        _ = id
        _ = event
        -- print(vim.inspect(data))
        for _, v in ipairs(data) do
            local s = string.gsub(v, "[\n\r]", "")
            -- Maintain consistent format when in unbuffered mode
            if v == "" then
                goto continue
            end
            -- Overwrite the first line in the buffer
            if append == false then
                vim.api.nvim_buf_set_lines(vim.g.output_bufnr, 0, -1, false, { s } )
                append = true
            else
                vim.api.nvim_buf_set_lines(vim.g.output_bufnr, -1, -1, false, { s } )
            end
        end
        ::continue::
    end

    if vim.g.output_bufnr == nil then
        layout.create_output_buffer()
    end

    local filepath = validate_path(path)
    if vim.api.nvim_buf_is_valid(vim.g.output_bufnr) then
        vim.fn.jobstart(filepath, {
            on_stdout = on_event,
            on_stderr = on_event,
            stdout_buffered = false,
            stderr_buffered = false,
        })
    end
end

return M

