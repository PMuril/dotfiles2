local options = {

    -- EDITOR SETTINGS
    tabstop           = 4,                 -- number of spaces to insert for each tab
    shiftwidth        = 4,                 -- number of spaces inserted for each indentation
    expandtab         = true,              -- converts tabs into spaces
    relativenumber    = true,              -- express line number as offset to the current line
    number            = true,              -- shows absolute line number at cursor position
    laststatus        = 2,                 -- Always show the status line
    clipboard         = "unnamedplus",      -- drops the distinction between the "+ and the "* registers
}

for k, v in pairs(options) do
    vim.opt[k] = v
end 
