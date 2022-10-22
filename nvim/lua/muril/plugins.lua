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
	
	-- text editing
	use "tpope/vim-commentary"
 	use 'https://github.com/tpope/vim-repeat'
 	-- use 'michaeljsmith/vim-indent-object' --treat indentation levels as vim text objects
  	-- use 'https://github.com/vim-scripts/ReplaceWithRegister'
	-- use 'https://github.com/christoomey/vim-system-copy'
	use 'mbbill/undotree'
	-- use 'https://github.com/glts/vim-magnum'	--bigint library for VIM
	-- use 'https://github.com/glts/vim-radical' 	--for istantaneously converting between numerical representations
 	-- use'wellle/targets.vim' "allows to easily target arguments inside functions
	--
	-- text navigation
	-- use 'https://github.com/adelarsq/vim-matchit'
 	-- use 'unblevable/quick-scope' 		--Highlights closest match when finding characters
 	-- use 'bkad/CamelCaseMotion' 			--Enables to specify text objects inside CamelCasedStrings and underlined_strings_
	
	-- airline customization
  	-- use 'vim-airline/vim-airline'
  	-- use 'vim-airline/vim-airline-themes'
	--
	-- git
	-- 'tpope/vim-fugitive'
	--
	-- snippets
	use "L3MON4D3/LuaSnip" --snippet engine
	use "rafamadriz/friendly-snippets" --snippets collection

	-- autocompletion 
	use "hrsh7th/nvim-cmp" --autocompletion engine
	use "hrsh7th/cmp-cmdline" --autocompletion engine
    use "hrsh7th/cmp-nvim-lsp"
	use "saadparwaiz1/cmp_luasnip" --autocompletion for luasnip snippets

	-- tree-sitter
	use "nvim-treesitter/nvim-treesitter"
	
	-- fuzzy-finding
	use 'nvim-lua/telescope.nvim'

	-- lsp 
	use 'neovim/nvim-lspconfig'
	-- use 'nvim-lua/completion-nvim'

	-- latex & markdown
	-- use "lervag/vimtex"
	-- use 'dhruvasagar/vim-table-mode'
	--

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end

end)


