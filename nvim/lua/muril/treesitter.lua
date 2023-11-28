-- since a dedicated xml parser is missing, use the html parser as
-- a fallback parser for xml files
local parser_mapping = require("nvim-treesitter.parsers").filetype_to_parsername
parser_mapping.xml = "html" -- map the html parser to be used when using xml files
-- parser_mapping.xsd = "html" -- map the html parser to be used when using xsd files
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "awk", "c", "cpp", "lua", "python", "bash", "vim", "make", "markdown", "markdown_inline", "rst", "latex", "regex", "cmake", "dockerfile", "html", "llvm", "json", "yaml", "toml", "ini", "query", "comment", "mermaid", "doxygen"}, --[[ query parser required from treesitter-playground ]]

    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { "markdown" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    indent = {enable = true, disable = { 'python'} },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        },
    },--[[  incrementa_slection ]]
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]p"] = "@parameter.inner",
        -- ["]]"] = { query = "@class.outer", desc = "Next class start" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        -- ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[p"] = "@parameter.inner",
        -- ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        -- ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
          enable = true,
          border = 'none',
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dc"] = "@class.outer",
          },
    },
  },--[[  textobjects ]]
}--[[  nvim-treesitter.configs ]]

