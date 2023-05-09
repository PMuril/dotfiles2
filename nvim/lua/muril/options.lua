local options = {
    -- EDITOR CORE SETTINGS
    tabstop        = 4, -- number of spaces to insert for each tab
    shiftwidth     = 4, -- number of spaces inserted for each indentation
    expandtab      = true, -- converts tabs into spaces
    relativenumber = true, -- express line number as offset to the current line
    number         = true, -- shows absolute line number at cursor position
    laststatus     = 2, -- Always show the status line. Set this value to 3 to enable global status line
    clipboard      = "unnamedplus", -- drops the distinction between the "+ and the "* registers
    ignorecase     = true, -- case insensitive text search by default
    undofile       = true, -- enables storage of command history under custom file
    undodir        = vim.env.HOME .. "/.config/nvim/undodir", -- specifies directory where to store the instructions
    foldmethod     = "expr", -- use custom method for folding
    foldexpr       = "nvim_treesitter#foldexpr()", -- use treesitter information for folding. Initial view si fully folded by default
    foldenable     = false, -- disable text folding on buffer openinig. Prevents treesitter from arbitrarly folding text
    formatoptions  = "jcql",
    listchars      = { lead = '⋅', trail = '⋅', tab = '→→' }, -- , eol = '↲'
    grepprg        = vim.fn.executable("rh") and "rg --vimgrep" or vim.opt.grepprg,

}

for k, v in pairs(options) do
    vim.opt[k] = v
end


vim.g.mapleader = " " -- leader key
vim.g.netrw_winsize=25

local abbreviations = {
    nw  = "nowrap",
    dt  = "DapTerminate",
    drt = "DapToggleRepl",
    drk = "bdelete! [dap-repl]",
    vx  = "Vexplore",
    co  = "copen",
    n   = "nohlsearch",
    du  = "DapUtils",
}

for abb, com in pairs(abbreviations) do
    vim.cmd('ab ' .. abb .. ' ' .. com)
end


-- PLUGINS SETTINGS

-- Camel Case Motion Settings
vim.g.camelcasemotion_key              = '<leader>'

-- Undo Tree Options
vim.g.undotree_RelativeTimestamp       = 1
vim.g.undotree_ShortIndicators         = 1
vim.g.undotree_HelpLine                = 0
vim.g.undotree_WindowLayout            = 2

-- Triggers quick-scope highlights only when performing motion to character
vim.g.qs_highlight_on_keys             = { 'f', 'F', 't', 'T' }

-- Vim table models
vim.g.table_mode_corner='|'

vim.g.table_mode_motion_up_map='{<Bar>'
vim.g.table_mode_motion_down_map='}<Bar>'
vim.g.table_mode_motion_left_map='[<Bar>'
vim.g.table_mode_motion_right_map=']<Bar>'
-- vim.g.table_mode_corner_corner='+'
-- vim.g.table_mode_header_fillchar='='

-- Vim Bookmarks
-- Disables default Vim Bookmarks keybindings as they have a great overlap with the defaults
vim.g.bookmark_no_default_key_mappings = 1

require('onedark').load()

-- TODO remove on next plugins update
require("todo-comments").setup {
    keywords = {
        QST = {
            icon = "? ",
            color = "default",
            alt = { "QUESTION" },
        },
    },
    merge_keywords = true,
    -- highlight = {
    --     multiline = true, -- enable multine todo comments
    --     multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
    --     multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    --     before = "", -- "fg" or "bg" or empty
    --     keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    --     after = "fg", -- "fg" or "bg" or empty
    --     pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    --     comments_only = false, -- uses treesitter to match keywords in comments only
    --     max_line_len = 400, -- ignore lines longer than this
    --     exclude = {}, -- list of file types to exclude highlighting
    -- },
}

vim.api.nvim_create_user_command('Vflog', ':vertical Flogsplit', {nargs = 0} )

-- vim.cmd[[colorscheme tokyonight]]
