local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system{'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packeradd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, "packer")
if not status_ok then return end return require('packer').startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- text editing
    use {'tpope/vim-abolish', opt = true}
    use {'tpope/vim-repeat', opt = true}
    use 'michaeljsmith/vim-indent-object' --treat indentation levels as vim text objects
    use 'vim-scripts/ReplaceWithRegister'

    use 'MattesGroeger/vim-bookmarks'
    
    use 'mbbill/undotree'
    use {'glts/vim-radical',                --for istantaneously converting between numerical representations (bin, oct, dec, hex)
        requires = {'glts/vim-magnum'}      --bigint library for VIM 
    }
    use {'wellle/targets.vim', disable = false} --allows to easily target arguments inside functions
    --
    -- text navigation
    use 'unblevable/quick-scope'        --Highlights closest match when finding characters
    use 'bkad/CamelCaseMotion'             --Enables to specify text objects inside CamelCasedStrings and underlined_strings_

    -- airline customization
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    -- lualine 
    use 'nvim-lualine/lualine.nvim'
    --
    -- git
    use { 'junegunn/gv.vim',
        requires = {'tpope/vim-fugitive'}
    }
    use "lewis6991/gitsigns.nvim"
    --
    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" --snippets collection

    -- autocompletion
    use {   "hrsh7th/nvim-cmp",             --autocompletion engine
            requires = {
                "hrsh7th/cmp-cmdline",      
                "hrsh7th/cmp-nvim-lsp",     -- lsp autocompletion
                "hrsh7th/cmp-nvim-lua",     -- autocompletion for neovim functions
                "hrsh7th/cmp-path",         -- autocompletion of filesystem paths
                "saadparwaiz1/cmp_luasnip", -- autocompletion for luasnip snippets
                "rcarriga/cmp-dap",         -- autocompletion of dap functions
            }
    }

    -- tree-sitter
    use {   
            "nvim-treesitter/nvim-treesitter",
            run = function() 
                pcall(require('nvim-treesitter.install').update { with_sync = true })
            end,
    }

    -- use { "numtostr/comment.nvim", after = {"nvim-treesitter"} }
    use { "numtostr/comment.nvim"}
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = {"nvim-treesitter"} }
    
    -- fuzzy-finding
    -- TELESCOPE
    use { 'nvim-lua/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim',                        -- common Lua functions collection
                    -- 'nvim-telescope/telescope-fzf-native.nvim',     -- native Telescope sorter that increases sorting performances 
        }        
    }
    -- Telescope extensions
    use 'nvim-telescope/telescope-dap.nvim'
    use 'tom-anders/telescope-vim-bookmarks.nvim'
    use 'benfowler/telescope-luasnip.nvim'
    -- personal plugins
    use {
        '~/.config/nvim/lua/muril/mypickers',
        requires = { 'nvim-lua/telescope.nvim' }
    }


    -- latex
    use 'lervag/vimtex'
    -- markdown
    use 'dhruvasagar/vim-table-mode'
    --
    -- wikis
    -- use 'lervag/wiki.vim'

    -- color schemes
    use 'navarasu/onedark.nvim'
    
    -- IDE-like functionalities
    -- lsp
    use "neovim/nvim-lspconfig"

    -- lsp-extensions (language specific)
    use 'p00f/clangd_extensions.nvim'

    -- debugging
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    --
    -- testing
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        }
    }
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
