local options = {

    -- EDITOR CORE SETTINGS
    tabstop           = 4,                            -- number of spaces to insert for each tab
    shiftwidth        = 4,                            -- number of spaces inserted for each indentation
    expandtab         = true,                         -- converts tabs into spaces
    relativenumber    = true,                         -- express line number as offset to the current line
    number            = true,                         -- shows absolute line number at cursor position
    laststatus        = 2,                            -- Always show the status line
    clipboard         = "unnamedplus",                -- drops the distinction between the "+ and the "* registers
    ignorecase        = true,                         -- case insensitive text search by default
    undofile          = true,                         -- enables storage of command history under custom file
    undodir           = vim.env.HOME .. "/.config/nvim/undodir", -- specifies directory where to store the instructions
}

for k, v in pairs(options) do
    vim.opt[k] = v
end


vim.g.mapleader = " " -- leader key

-- PLUGINS SETTINGS

-- Camel Case Motion Settings
vim.g.camelcasemotion_key = '<leader>'

-- Undo Tree Options
vim.g.undotree_RelativeTimestamp = 1
vim.g.undotree_ShortIndicators   = 1
vim.g.undotree_HelpLine          = 0
vim.g.undotree_WindowLayout      = 2
vim.g.camelcasemotion_key        = "<leader>"



require('Comment').setup()

require('onedark').setup {
    -- for customization refer to the GitHub repository https://github.com/navarasu/onedark.nvim
    style = 'dark'
}
require('onedark').load()
