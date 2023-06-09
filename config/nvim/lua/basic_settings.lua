vim.o.modelines = 0
vim.o.compatible = false
vim.o.backspace = '2'

vim.o.writebackup = false
vim.o.backup = false

vim.g.skip_defaults_vim = 1

vim.o.number = true
vim.o.autoindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.hidden = true
vim.o.laststatus = 3
vim.o.cmdheight = 0
vim.o.swapfile = false

vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.tags = vim.o.tags .. ',.tags_columns'

vim.g.mapleader = ' '
vim.g.maplocalleader = [[  ]]

if not vim.g.vscode then
    vim.o.mouse = 'a'
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
    vim.o.termguicolors = true

    local gui_font = {
        'JetBrains_Mono_Nerd_Font_Complete:h15',
        'Sauce_Code_Pro_Nerd_Font_Complete:h15',
        'Monaco_Nerd_Font_Complete:h15',
        'SF_Mono_Regular:h15',
        'Space_Mono_Nerd_Font_Complete:h15',
        'Monego_Nerd_Font_Fix:h15',
        'CaskaydiaCove_Nerd_Font:h15',
    }

    local gui_cursor = {
        'n-v-c:block',
        'i-ci-ve:ver70',
        'r-cr:hor20',
        'o:hor50',
        'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
        'sm:block-blinkwait175-blinkoff150-blinkon175',
    }

    vim.o.guifont = gui_font[6]
    vim.o.guicursor = table.concat(gui_cursor, ',')
end
