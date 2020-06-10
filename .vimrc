" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile

" Better search display
nnoremap <silent> n n:call <SID>MaybeMiddle()<CR>
nnoremap <silent> N N:call <SID>MaybeMiddle()<CR>
" If cursor is in first or last line of window, scroll to middle line.
function s:MaybeMiddle()
    if winline() == 1 || winline() == winheight(0)
        normal! zz
    endif
endfunction

" Buffer switch
nnoremap gb :bn<cr>
nnoremap gB :bp<cr>
nnoremap gd :bp<cr>:bd #<cr>

let mapleader = " "

" Window switch
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" It turns out I will never use horizontal split window in vim, so just make
" +/- change the vertical window size
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
if bufwinnr(1)
    map + <leader>+
    map - <leader>-
endif 

" Quickfix window and Location list navigation
nmap <C-j> :cnext<CR>
nmap <C-k> :cprev<CR>
" Note the following two keys only work on Mac
nmap ∆ :lnext<CR>
nmap ˚ :lprev<CR>

" Remove esc delay
set timeoutlen=1000 ttimeoutlen=0

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'djoshea/vim-autoread'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'milkypostman/vim-togglelist'

call plug#end()

" gruvbox
colorscheme gruvbox
set background=dark

" airline
let g:airline_powerline_fonts = 1
" Remove file type
let g:airline_section_x = ''
" Remove empty sections
let g:airline_skip_empty_sections = 1
" Enable tabline. When there is only one tab, all buffers will be shown;
" otherwise, only tabs will be shown
let g:airline#extensions#tabline#enabled = 1
" Remove tab number before filename
let g:airline#extensions#tabline#show_tab_nr = 0
" Remove useless info at top right
let g:airline#extensions#tabline#tab_label = ''
let g:airline#extensions#tabline#show_splits = 0

" nerdtree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
" Show some dot files
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$', '\.DS_Store']
" Automatically open nerdtree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close nerdtree if it is the only left window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Remap s to v to be consistent with ctrlp
let NERDTreeMapOpenVSplit = 'v'

" ctrlp
nnoremap <silent> <leader>p :CtrlP<CR>
" Disable cache (fast enough)
let g:ctrlp_use_caching = 0
" Show dot files
let g:ctrlp_show_hidden = 1

" youcompleteme
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>rr :YcmCompleter RefactorRename<space>
nnoremap <silent> <leader>gt :YcmCompleter GetType<CR>
nnoremap <silent> <leader>gT :YcmCompleter GoToType<CR>
" Don't auto-quit the quickfix window
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
" Populate the diagnostic message in the locationlist
let g:ycm_always_populate_location_list = 1

" vim-go
" Highlight all function calls
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" ack
nnoremap <leader>a :Ack!<space>

" easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" smartcase
let g:EasyMotion_smartcase = 1
map <leader>w <Plug>(easymotion-bd-f2)
nmap <leader>w <Plug>(easymotion-overwin-f2)

" togglelsit
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>t :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
