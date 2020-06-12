" ---------------------------------------------------------------------------------------
" Basic Settings
" ---------------------------------------------------------------------------------------
set nocompatible
syntax on
" Disable the default Vim startup message.
set shortmess+=I
" Don't pass messages to |ins-completion-menu|
set shortmess+=c
set number
set relativenumber
" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2
" More intuitive backspace key
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
set incsearch
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=
" Enable mouse support
set mouse+=a
" Prevent bad habits like using the arrow keys for movement
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" Tab width
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set nowritebackup
" Better search display
nnoremap <silent> n n:call <SID>MaybeMiddle()<CR>
nnoremap <silent> N N:call <SID>MaybeMiddle()<CR>
" If cursor is in first or last line of window, scroll to middle line.
function s:MaybeMiddle()
    if winline() == 1 || winline() == winheight(0)
        normal! zz
    endif
endfunctio
" Remove the delay when quitting the visual mode
set timeoutlen=1000 ttimeoutlen=0
set encoding=UTF-8
set updatetime=300

" ---------------------------------------------------------------------------------------
" Basic Remappings
" ---------------------------------------------------------------------------------------
let mapleader = " "

" Buffers
nnoremap gb :bn<cr>
nnoremap gB :bp<cr>
nnoremap gd :bp<cr>:bd #<cr>

" Window switch
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Make vertical window resizing easier
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
if bufwinnr(1)
    map + <leader>+
    map - <leader>-
endif 

" Quickfix window navigation
nmap <C-j> :cnext<CR>
nmap <C-k> :cprev<CR>

" ---------------------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------------------
" Vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'djoshea/vim-autoread'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'milkypostman/vim-togglelist'
Plug 'tomasiser/vim-code-dark'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Vim-devicons must be the very last one
Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme codedark

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'codedark'
" Remove file type section
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

" Nerdtree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
" Show some dot files
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$', '\.DS_Store', '\.localized']
" Automatically open nerdtree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close nerdtree if it is the only left window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Remap s to v to be consistent with other plugins
let NERDTreeMapOpenVSplit = 'v'

" Ctrlp
nnoremap <silent> <leader>p :CtrlP<CR>
" Disable cache (fast enough)
let g:ctrlp_use_caching = 0
" Show dot files
let g:ctrlp_show_hidden = 1

" Ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Vim-go
" Highlight all function calls
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" Auto import
let g:go_fmt_command = "goimports"
" Disable all vim-go mappings (coc is enough)
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0

" Ack
nnoremap <leader>a :Ack!<space>

" Easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <leader>w <Plug>(easymotion-bd-f2)
nmap <leader>w <Plug>(easymotion-overwin-f2)

" Togglelsit
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" Coc
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif
" Use tab for auto-completion list navigation
let g:SuperTabDefaultCompletionType = '<C-n>'
" Use <c-space> to show completion list (in iTerm2, <NUL> is sent when
" press <c-space>)
inoremap <silent><expr> <NUL> coc#refresh()
" Use <cr> to confirm completion
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Navigate diagnostics (the two keys only work in Mac, which represents
" <option-k> and <option-j>)
nmap <silent> ˚ <Plug>(coc-diagnostic-prev)
nmap <silent> ∆ <Plug>(coc-diagnostic-next)
" Use K to show documentation in floating window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" Required bindings
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>gf <Plug>(coc-fix-current)
nnoremap <silent><nowait> <leader>sd :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>so :<C-u>CocList outline<cr>
" Highlight the symbol and its references when holding the cursor
highlight CocHighlightText ctermbg=59 guibg=#5f5f5f
autocmd CursorHold * silent call CocActionAsync('highlight')
" Function and class selection
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Use :Format to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use :Import to organize imports of current buffer
command! -nargs=0 Import :call CocAction('runCommand', 'editor.action.organizeImport')
