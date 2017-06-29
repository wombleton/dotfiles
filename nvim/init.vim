set nocompatible              " be iMproved, required
filetype off                  " required

set shell=/bin/bash"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Plugins
"

Plugin 'VundleVim/Vundle.vim'
Plugin 'ruanyl/vim-fixmyjs'
Plugin 'scrooloose/nerdtree'
Plugin 'freeo/vim-kalisi'
Plugin 'altercation/vim-colors-solarized'
Plugin 'spf13/vim-colors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'flazz/vim-colorschemes'
Plugin 'mbbill/undotree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mhinz/vim-signify'
Plugin 'osyo-manga/vim-over'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'maralla/completor.vim'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'fatih/vim-go'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'burnettk/vim-angular'
Plugin 'ternjs/tern_for_vim'

"
" End Plugins
"
call vundle#end()            " required
filetype plugin indent on    " required

" change the mapleader from \ to ,
let mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

filetype plugin indent on   " Automatically detect file types.
syntax enable                   " Syntax highlighting

set autowrite                       " Automatically write a file when leaving a modified buffer
set history=1000                    " Store a ton of history (default is 20)

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set cursorline                  " Highlight current line

" Auto-reload modified files (with no local changes)
set autoread

" Turn off backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Spaces not tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" Remove trailing whitespace whenever saving files
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif

" Incremental search
set incsearch

" Smart case matching
set smartcase

" Show matching brackets
set showmatch

" Always show line numbers
set number

" Always show status line
set laststatus=2

" Let's see some useful info in the status line
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P

" Use a dark background
" set background=dark
set background=light

" Use solarized colorscheme
colorscheme kalisi

" Fix long lines causing pattern matching OOM errors
set maxmempattern=32768

" Allow modelines
set modeline

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
"
" src: http://vim.wikia.com/wiki/Modeline_magic
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d filetype=%s :",
        \ &tabstop, &shiftwidth, &textwidth, &filetype)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
" vim: set ts=2 sw=2 tw=78 filetype=vim :
set vb t_vb=

au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.ejs set filetype=html
au BufRead,BufNewFile *.go set filetype=go 

autocmd FileType tmpl setlocal shiftwidth=4 tabstop=4
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" Map terndef
au FileType javascript nmap <silent> <leader>d :TernDef<CR>
au FileType go nmap <silent> <leader>d :GoDef<CR>

" buffer
nmap <leader>nh   :leftabove  vnew<CR>
nmap <leader>nl  :rightbelow vnew<CR>
nmap <leader>nk     :leftabove  new<CR>
nmap <leader>nj   :rightbelow new<CR>

" Map ctrl-movement keys to window switching
map <leader>k <C-w><Up>
map <leader>j <C-w><Down>
map <leader>l <C-w><Right>
map <leader>h <C-w><Left>

nmap <C-P> :CtrlP<CR>
nmap <C-B> :CtrlPMRU<CR>
nmap <C-G> :lnext<CR>

" NerdTree {
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    map <C-e> <plug>NERDTreeTabsToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif

" ctrlp {
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    " On Windows use "dir" as fallback command.
    let s:ctrlp_fallback = 'find %s -type f'
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }

    if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']

        "funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif
endif
"}

autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']
let g:syntastic_javascript_standard_exec = 'semistandard'
let g:syntastic_always_populate_loc_list=1
let g:completor_node_binary = '/Users/behemoth/.nvm/versions/node/v8.1.0/bin/node'
let g:completor_gocode_binary = '/Users/behemoth/go/bin/gocode'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
