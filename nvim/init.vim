filetype plugin on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
:set relativenumber
:set number
:set number relativenumber
set laststatus=2

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
:nnoremap Q <Nop>

" enables powerline fonts for the airline plugin (see below)
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set t_Co=256
" Specify the plugins installation directories
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/xavierd/clang_complete'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister'
Plug 'https://github.com/christoomey/vim-system-copy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'https://github.com/christoomey/vim-tmux-navigator'
call plug#end()
