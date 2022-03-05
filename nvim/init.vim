filetype plugin on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber "triggers relative lines numbering except for current line, where shows absolute
set laststatus=2

" KEYBINDINGS
" sets the leader key
let mapleader="\\"

" Disables arrows keys in Normal Mode 
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Disables arrows keys in Insert Mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Disable ex mode
nnoremap Q <Nop>

" Case-insensitive text search by default
set ignorecase

" Undotree settings
nnoremap <A-t> :UndotreeToggle<CR>
let g:undotree_RelativeTimestamp = 1
let g:undotree_ShortIndicators = 1
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 2

if has("persistent_undo")
    set undodir=$HOME/.config/nvim/undodir
    set undofile
endif

" enables powerline fonts for the airline plugin (see below)
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set t_Co=256

"HIGHLIGHTING

" makes the highlight under the current line persistent
" press \l to highlight, :match to remove the highlight
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

"specifies the highlighting profile
highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white

" Specify the plugins installation directories
" clang_complete requires to install nvim with python support
" the installation can be performed via 'pip3 install neovim'
call plug#begin('~/.vim/plugged')

" Plugins list
" to perform plugins update/installation run \"PlugInstall\"
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister'
Plug 'https://github.com/christoomey/vim-system-copy'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/glts/vim-magnum' 
Plug 'https://github.com/glts/vim-radical' "for istantaneously converting between numerical representations
Plug 'https://github.com/kana/vim-textobj-user' "dependency of vim-textobj-latex
Plug 'https://github.com/rbonvall/vim-textobj-latex' "for yanking inside latex-defined environments
Plug 'michaeljsmith/vim-indent-object' "treat indentation levels as vim text objects
Plug 'https://github.com/bkad/CamelCaseMotion' "allows to specify text objects inside CamelCasedStrings and underlined_strings_
Plug 'wellle/targets.vim' "allows to easily target arguments inside functions
Plug 'unblevable/quick-scope' "Highlights closest match when finding characters
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'https://github.com/christoomey/vim-tmux-navigator'
call plug#end()

" Plugins Settings
" Sets the leader key as the key to prepend to the motion symbol to
" identify inner text objects in the CamelCaseMotion plugin
let g:camelcasemotion_key = '<leader>'

" enables the // comment style for the programming languages below
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" quick scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Ultisnips
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set runtimepath+=~/.config/nvim/my-snippets/

" Custom text objects (requires kana's vim-textobj-user
" Lines below should be outdated due the CamelCaseMotionPlugin
" call textobj#user#plugin('dashes', {
" \   'dash-a' : {
" \      'pattern': '[-][^-]*[-]',
" \       'select': 'ay',
" \   },
" \   'dash-i' : {
" \      'pattern': '[-]\zs[^-]*\ze[-]',
" \       'select': 'iy',
" \   },
" \   'underscore-a' : {
" \      'pattern': '[_][^_]*[_]',
" \      'select': 'aY', 
" \   },
" \   'underscore-i' : {
" \      'pattern': '[_]\zs[^_]*\ze[_]',
" \      'select': 'iY', 
" \   },
" \ })
"
