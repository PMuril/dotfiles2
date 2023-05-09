local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup( {

    -- text editing
     {'tpope/vim-abolish', opt = true},
     {'tpope/vim-repeat', opt = true},
     'michaeljsmith/vim-indent-object', --treat indentation levels as vim text objects
     'vim-scripts/ReplaceWithRegister',

     {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup() end
    },

     {'folke/todo-comments.nvim',
        dependencies = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup({
            keywords = {
                QST = {
                    icon = "? ",
                    color = "default",
                    alt = {"QUESTION"},
                },
            },
            merge_keywords = true,
        }) end,
    },

     'MattesGroeger/vim-bookmarks',
     'mbbill/undotree',
     {'glts/vim-radical',                --for istantaneously converting between numerical representations (bin, oct, dec, hex)
        dependencies = {'glts/vim-magnum'}      --bigint library for VIM 
    },
     {'wellle/targets.vim', disable = true}, --allows to easily target arguments inside functions
    --
    -- text navigation
    --  'unblevable/quick-scope'            --Highlights closest match when finding characters
     'bkad/CamelCaseMotion',             --Enables to specify text objects inside CamelCasedStrings and underlined_strings_

    -- Editor Layout
    -- lualine 
     {'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup {
                sections = { lualine_c = {{'filename', path=0}} }
            }
            end
    },

    --  'romgrk/barbar.nvim.git'

    -- color schemes
     { 'navarasu/onedark.nvim',
        config = function () require('onedark').setup { style = 'darker' } end,
		init = function () require('onedark').load() end,
    },
    --  'folke/tokyonight.nvim'

    -- Git
     { 'rbong/vim-flog',
        dependencies = {'tpope/vim-fugitive'}
    },
     { "lewis6991/gitsigns.nvim",
        config = function ()
            require("gitsigns").setup()
        end
    },
    --
    -- snippets
     "L3MON4D3/LuaSnip", --snippet engine
     "rafamadriz/friendly-snippets", --snippets collection

    -- autocompletion
"hrsh7th/nvim-cmp",             --autocompletion engine
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp",     -- lsp autocompletion
                "hrsh7th/cmp-path",         -- autocompletion of filesystem paths
                "saadparwaiz1/cmp_luasnip", -- autocompletion for luasnip snippets
                "rcarriga/cmp-dap",         -- autocompletion of dap functions

     { 'folke/neodev.nvim',
        config = function () require('neodev').setup({}) end
    },


    -- tree-sitter
     {
            "nvim-treesitter/nvim-treesitter",
            -- build = ":TSUpdate",
    },

    --  { "numtostr/comment.nvim", after = {"nvim-treesitter"} }
     {
        "numtostr/comment.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
        config = function () require('Comment').setup() end
    },
     { "nvim-treesitter/nvim-treesitter-textobjects"},
     { "nvim-treesitter/playground"},


    -- fuzzy-finding
    -- TELESCOPE
     { 'nvim-lua/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim',                        -- common Lua functions collection
                    {
                    'nvim-telescope/telescope-fzf-native.nvim',     -- native Telescope sorter that increases sorting performances 
                     build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                    }
        }
    },

    -- Telescope extensions
     'nvim-telescope/telescope-dap.nvim',
     'tom-anders/telescope-vim-bookmarks.nvim',
     'benfowler/telescope-luasnip.nvim',
     'nvim-telescope/telescope-project.nvim',
     'nvim-telescope/telescope-ui-select.nvim',
     'nvim-telescope/telescope-live-grep-args.nvim',
     'debugloop/telescope-undo.nvim',
     {
        'nvim-telescope/telescope-media-files.nvim',
        dependencies = {'nvim-lua/popup.nvim'}
    },

    -- personal plugins
     {
         dir = '~/.config/nvim/lua/muril/mypickers',
         dependencies = { 'nvim-lua/telescope.nvim' }
     },
     {
        'danymat/neogen',
        config = function()
            require('neogen').setup( { snippet_engine = "luasnip"} )
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- latex
     'lervag/vimtex',
    -- markdown
     'dhruvasagar/vim-table-mode',
    --
    -- wikis
     'lervag/wiki.vim',
    --  'vimwiki/vimwiki' -- Disabled due to problems with Treesitter markdown parsing


    -- IDE-like functionalities
    -- lsp
     "neovim/nvim-lspconfig",
     "jose-elias-alvarez/null-ls.nvim",

     {
      "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    },

    -- lsp-extensions (language specific)
     'p00f/clangd_extensions.nvim',

    -- Python
    --  'goerz/jupytext.vim'
    --  {'hkupty/iron.nvim'}

    -- debugging
     'mfussenegger/nvim-dap',
     { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
     { "theHamsta/nvim-dap-virtual-text", dependencies = {"mfussenegger/nvim-dap"} },

    -- testing
     { "vim-test/vim-test" },
     {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        }
    },

}
)
