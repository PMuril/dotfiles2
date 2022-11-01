local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system{'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packeradd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return require('packer').startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    
    -- Lua utility functions
    use 'nvim-lua/plenary.nvim'

    -- text editing
    -- use "tpope/vim-commentary"
    use 'https://github.com/tpope/vim-repeat'
    use 'michaeljsmith/vim-indent-object' --treat indentation levels as vim text objects
    use 'https://github.com/vim-scripts/ReplaceWithRegister'
    --
    use 'mbbill/undotree'
    use 'https://github.com/glts/vim-magnum'    --bigint library for VIM - dependency of vim-radical
    use 'https://github.com/glts/vim-radical'     --for istantaneously converting between numerical representations
     use 'wellle/targets.vim'                    --allows to easily target arguments inside functions
    --
    -- text navigation
     -- use 'unblevable/quick-scope'         --Highlights closest match when finding characters
     use 'bkad/CamelCaseMotion'             --Enables to specify text objects inside CamelCasedStrings and underlined_strings_

    -- airline customization
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    -- lualine 
    -- use {
    -- 'nvim-lualine/lualine.nvim',
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    -- }
    -- use ' 
    --
    -- git
    use "airblade/vim-gitgutter"
    --
    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" --snippets collection

    -- autocompletion
    use "hrsh7th/nvim-cmp"      --autocompletion engine
    use "hrsh7th/cmp-cmdline"   --autocompletion engine
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip" --autocompletion for luasnip snippets

    -- tree-sitter
    use "nvim-treesitter/nvim-treesitter"
    -- use "JoosepAlviste/nvim-ts-context-commentstring" --contex-aware comments (for files embedding multiple languages)
    use "numtostr/comment.nvim"                     -- language-aware comments
    use "nvim-treesitter/nvim-treesitter-textobjects"
    

    -- fuzzy-finding
    use 'nvim-lua/telescope.nvim'

    -- lsp
    use "neovim/nvim-lspconfig"
    -- use 'nvim-lua/completion-nvim'

    -- latex
    use 'lervag/vimtex'
    -- markdown
    -- use 'dhruvasagar/vim-table-mode'
 
    -- color schemes
    use 'navarasu/onedark.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
