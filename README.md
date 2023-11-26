<div align="center">

# Outhouse.nvim
Displays subprocess output in a window within the editor.

</div>

![Preview](https://i.imgur.com/tNelVa0.gif)

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'cyn1x/outhouse.nvim'
```

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
'outhouse.nvim'
```

## Usage

Call `handler.subprocess()` to run an external program.

```lua
require('outhouse').setup{
    disabled = false,
    auto_start = false,
    vertical = true,
}

local handler = require('outhouse.handler')

vim.keymap.set("n", "<leader><leader>x", function()
    if vim.fn.has("win32") == 1 then
        handler.subprocess(vim.g.win32_build_filename)
    elseif vim.fn.has("unix") == 1 then
        handler.subprocess(vim.g.unix_build_filename)
    else
        error("Platform not supported", 2)
    end
end)
```

The example above assumes that the project root directory where `nvim` was started in contains an `.init.lua` file with global variables denoting the path of their corresponding build scripts. If the global variables do not exist or their paths are invalid, the program will prompt for a file path.

## Contributing

Pull requests are welcome.

## License

[MIT](https://choosealicense.com/licenses/mit/)
