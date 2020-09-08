execute pathogen#infect()
runtime macros/matchit.vim
let mapleader = "\<Space>"
filetype plugin indent on
syntax enable
highlight cursorcolumn ctermbg=blue
highlight cursorcolumn ctermfg=green
highlight CursorColumn cterm=NONE ctermbg=239
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
highlight incsearch ctermbg=Black
highlight incsearch ctermfg=Yellow
highlight Search ctermbg=Yellow
highlight Search ctermfg=Black
set autoindent
set autoread
set cursorcolumn
set cursorline
set expandtab
set fileencodings=utf-8,sjis,euc-jp,latin1
set fileformats=unix,dos,mac
set history=200
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-,nbsp:%
set matchtime=1
set nobackup
set nocompatible
set number
set pastetoggle=<f5>
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set tabstop=4
set title
set wildmenu
set wildmode=full
set statusline=%f\ [%l/%L]
augroup format-unix
    autocmd!
    autocmd BufRead *.php,*.js,*.html,*.htm e ++ff=unix | syntax enable
augroup END
augroup format-dos
    autocmd!
    autocmd BufRead *.bas,*.cls,*.frm e ++enc=sjis ++ff=dos | set filetype=basic | syntax enable
augroup END
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap / /\v
nnoremap <leader>j `m
nnoremap <leader>J `M
nnoremap <leader>w :w<CR>
nnoremap <leader>E :e!<CR>
nnoremap <leader>Q :qall!<CR>
nnoremap <leader>S :sh<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <leader>N :set number!<CR>
nnoremap <silent> <leader>n :set relativenumber!<CR>
nnoremap <leader>s :%s///g<C-f>hhi
vnoremap <leader>s :s///g<C-f>hhi
noremap & :&&<CR>
xnoremap & :&&<CR>
inoremap jk <esc>
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

