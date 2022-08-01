filetype plugin indent on
syntax on

" mapleader
let mapleader="\<Space>"

""" Sets the "old" syntax highlighting engine for vim-go: https://github.com/fatih/vim-go/issues/72
set re=2

set number
set encoding=utf-8
set hidden

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set modifiable
set updatetime=10

set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set splitright

set incsearch
set hlsearch


" Highlight the line and column where the cursor is located.
set cursorcolumn
set cursorline


set nowrap
set scrolloff=2
set autoread
set ruler

set expandtab

" C-a delete octal, same for bin and hex
set nrformats=bin,hex

"comments newline delete comments
set formatoptions=tcqj


"set smartindent
"set cindent
set autoindent

if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif


"nnoremap d "_d
"nnoremap x d
"nnoremap xx dd

noremap <C-p> "0p



noremap + :<C-u>bnext<CR>
noremap _ :<C-u>bprevious<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

set keywordprg=:help

set wildmenu
set wildmode=longest:full,full


noremap <silent>  <C-w><C-m> :call Tabopen()<CR>
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
          let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" xml
set foldtext=FoldText()
function FoldText()
    let l:line = s:GetText(v:foldstart, v:foldend) .' '
    let l:info = printf('--- lines:%3d', v:foldend - v:foldstart + 1)

    let l:colorcolumn = empty(&l:colorcolumn) ? 200 : &l:colorcolumn
    let l:text_width = l:colorcolumn - len(l:info) - 1
    let l:space = l:text_width - len(l:line)
    if l:space > 0
        let l:text = l:line . repeat('-', l:space)
    else
        let l:text = l:line[: l:space - 3] .'… '
    endif

    return l:text . l:info
endfunction

function s:GetText(foldstart, foldend) abort
    let l:line = getline(a:foldstart)

    if &l:foldmethod ==# 'marker'
        let [l:start_marker, l:end_marker] = split(&l:foldmarker, ',')
        let l:regex = '"\?\s*'. l:start_marker .'\d*\s*$'
        let l:text = substitute(l:line, l:regex, '' , '')
        if match(l:text, '^\s*$') != -1
            let l:next_line = getline(a:foldstart + 1)
            if match(l:next_line, l:start_marker . '\|' . l:end_marker) != -1
                return l:line
            else
                return l:next_line
            endif
        endif
        return l:text
    elseif &l:foldmethod ==# 'syntax'
        if &l:filetype ==# 'json'
            let [l:pair_start, l:start, l:end] =
                        \ matchstrpos(l:line, '\v^%([^"]|"%([^"]|\")*"){-}\zs[{[]')
            let l:pair_end = l:pair_start ==# '[' ? ']' : '}'

            let l:endline = getline(a:foldend)
            let l:comma = matchstr(l:endline, l:pair_end .'\s\{-}\zs,\ze.\{-}$')

            let l:text = l:line[: l:start] .'…'. l:pair_end . l:comma
            return l:text
        endif
    endif

    return substitute(l:line, '	', repeat(' ', &l:tabstop), 'g')
endfunction

function Tabopen() abort
    let l:view = winsaveview()
    tabnew %
    call winrestview(l:view)
endfunction


hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=None guibg=lightgray guifg=white

cnoreabbrev help botright vertical help

augroup myAutocmd
    autocmd!
    autocmd BufWritePost ~/.vimrc source %
    autocmd BufWinEnter * if &buftype=="help" | wincmd L
    autocmd FileType vim,help setlocal keywordprg=:help
    autocmd FileType xml,json setlocal foldmethod=syntax
augroup END

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" vim-star
vmap <silent> * <Plug>(star-*)
vmap <silent> # <Plug>(star-#)
nmap <silent> * <Plug>(star-*)
nmap <silent> # <Plug>(star-#)
nmap <silent> g* <Plug>(star-g*)
nmap <silent> g# <Plug>(star-g#)

" coc-Plug
let g:coc_global_extensions = [
            \   'coc-word',
            \   'coc-highlight',
            \   'coc-snippets',
            \   'coc-json',
            \   'coc-pyright',
            \   'coc-vimlsp',
            \   'coc-translator',
            \   'coc-explorer',
            \   'coc-yank',
            \   'coc-yaml',
            \]

" coc-explorer map
nnoremap <space>e :CocCommand explorer<CR>

hi Pmenu ctermfg=15 ctermbg=242 guibg=DarkGrey

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:ale_python_flake8_options = '--max-line-length=100 --ignore=E203,W503,D105,D107,DAR203'

" ale Plug
let g:ale_python_pylint_options = join([
            \   '--good-names=i,j,k,x,y,z,w,fp',
            \   '--disable=bad-continuation',
            \   '--generated-members=torch.\*,cv2.\*',
            \   '--ignored-modules=tensorflow.compat.v1'
            \], ',')
let g:ale_python_mypy_options = join([
            \   '--cache-dir=/tmp/mypy_cache',
            \   '--ignore-missing-imports',
            \   '--follow-imports=silent',
            \   '--warn-unreachable',
            \   '--show-error-codes',
            \   '--strict-equality',
            \   '--strict',
            \])
let g:ale_linters = {'python': ['flake8', 'pylint', 'mypy']}
let g:ale_linters_explicit = 1
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗️'
let g:ale_sign_info = '❓'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'

" ag search CtrlSF
let g:ctrlsf_ackprg = 'ag'

"airline/airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" auto format
nnoremap <leader>fo :Autoformat<CR>
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatdef_clang_format = "'clang-format ".
            \                  "-lines='.a:firstline.':'.a:lastline.' ".
            \                  "--assume-filename=\"'.expand('%:p').'\" ".
            \                  "-style=file'"
let g:formatters_cpp = ['clang_format']
let g:formatters_proto = ['clang_format']

let g:formatdef_buildifier = "'buildifier'"
let g:formatters_bzl = ['buildifier']

let g:formatdef_isort = "'isort -w 100 -'"
let g:formatdef_docformatter =
            \ "'docformatter --wrap-summaries 100 --wrap-descriptions 100 --blank -'"
let g:formatdef_black = "'black -q -l 100 -'"
let g:formatdef_pyupgrade = "'pyupgrade --py36-plus -'"
let g:formatdef_python_format = join([
            \   g:formatdef_isort[:-2],
            \   g:formatdef_docformatter[1:-2],
            \   g:formatdef_pyupgrade[1:-2],
            \   g:formatdef_black[1:],
            \ ], ' | ')
let g:formatters_python = ['python_format']

"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0
"let g:autoformat_verbosemode = 0
"let g:formatdef_black_isort = "'isort --profile=black -w 100 - | black -q -l 100 -'"
"let g:formatters_python = ['black_isort']

" json autoformat
nnoremap <leader>jq :%!jq -M -r --indent 4<CR>
xnoremap <leader>jq :!jq -M -r --indent 4<CR>
nnoremap <leader>jw :%!jq -M -c<CR>
xnoremap <leader>jw :!jq -M -c<CR>
" vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'tpope/vim-surround'
Plug 'linjiX/vim-star', {'on': '<Plug>(star-'}
Plug 'preservim/tagbar', {'on': ['Tagbar', 'TagbarOpen']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': 'Leaderf' }
Plug 'Chiel92/vim-autoformat'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'tomasr/molokai'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'dyng/ctrlsf.vim'
Plug 'yianwillis/vimcdoc'
"Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" fuzzy search "
Plug 'dhruvasagar/vim-table-mode'

" lesson 3
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-endwise'

" lesson4
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rafi/awesome-vim-colorschemes'

" lesson5
Plug 'rhysd/conflict-marker.vim'

" lesson6
call plug#end()


let g:airline_theme = "bubblegum"
" colorscheme
"colorscheme molokai
colorscheme tender
"let g:molokai_original = 1
"let g:rehash256 = 1


" Leaderf search logic
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']

" search files, functions, any other...
nnoremap <leader>o :Leaderf function<CR>
nnoremap <leader>fe :Leaderf file<CR>
nnoremap <leader>fl :Leaderf line<CR>

" rhysd/conflict-marker.vim
let g:conflict_marker_enable_mappings = 0

nmap ]k <Plug>(conflict-marker-next-hunk)
nmap [k <Plug>(conflict-marker-prev-hunk)

nmap <leader>cj <Plug>(conflict-marker-themselves)
nmap <leader>ck <Plug>(conflict-marker-ourselves)
nmap <leader>cN <Plug>(conflict-marker-none)
nmap <leader>cB <Plug>(conflict-marker-both)
