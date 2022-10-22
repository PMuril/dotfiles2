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

" vimgrep useful keybindigs
set grepprg=internal
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [<C-q> :cpfile<CR>
nnoremap ]<C-q> :cnfile<CR>

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

" Custom highlighting colors
highlight RedSearch cterm=NONE ctermbg=darkred ctermfg=white

" enables the Dockerfile syntax highlighting for .dockerfile files
autocmd BufNewFile,BufRead *.dockerfile set syntax=dockerfile

" FOLDING
autocmd FileType c,cpp,cs,java set foldmethod=syntax

autocmd FileType xml set foldmethod=indent

if(exists("g:vscode"))
    " Get folding working with vscode neovim plugin
    nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
    nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
    nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
    nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
    nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
    nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>
    " xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>

    nnoremap <silent> z1 <Cmd>call VSCodeNotify('editor.foldLevel1')<CR>
    nnoremap <silent> z2 <Cmd>call VSCodeNotify('editor.foldLevel2')<CR>
    nnoremap <silent> z3 <Cmd>call VSCodeNotify('editor.foldLevel3')<CR>
    nnoremap <silent> z4 <Cmd>call VSCodeNotify('editor.foldLevel4')<CR>
    nnoremap <silent> z5 <Cmd>call VSCodeNotify('editor.foldLevel5')<CR>
    nnoremap <silent> z6 <Cmd>call VSCodeNotify('editor.foldLevel6')<CR>
    nnoremap <silent> z7 <Cmd>call VSCodeNotify('editor.foldLevel7')<CR>
    
    nmap j gj
    nmap k gk
    
    " Bookmarks
    nnoremap <silent> gb <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
    nnoremap <silent> glb <Cmd>call VSCodeNotify('bookmarks.toggleLabeled')<CR>

    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine

    autocmd FileType json setlocal commentstring=//\ %s

    " fixes the missing highlights in vscode
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

    " ultisnips keybindings
    " let g:UltiSnipsExpandTrigger="<c-/>"
    " let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-z>"
endif


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
Plug 'lervag/vimtex'
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

" PLUGINS SETTINGS
" CamelCaseMotion
" sets the leader key as the key to prepend to the motion symbol to
" identify inner text objects in the CamelCaseMotion plugin
let g:camelcasemotion_key = '<leader>'

" VimCommentary
" enables the // comment style for the programming languages below
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" Quick-Scope
" Trigger a highlight in the appropriate direction when pressing these keys:
"
set runtimepath+=~/.config/nvim/my-snippets/Ultisnips
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
