set number
" hyuzuvimrc
set nocompatible
set encoding=utf-8
set fileformats=unix,dos,mac

augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

filetype off

" =======================================
" NeoBundle
" =======================================

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build': {
      \   'windows'   : 'make -f make_mingw32.mak',
      \   'mac'       : 'make -f make_mac.mak',
      \   'unix'      : 'make -f make_unix.mak',
      \ }}

NeoBundleLazy 'Shougo/neocomplete', { 'autoload' : {
      \   'insert' : 1,
      \ }}
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/vimshell',{
      \'depends' : ['Shougo/vimproc'],
      \'autoload':{
      \'commands':['VimShellBufferDir','VimShellPop']
      \}}  
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/unite-outline', {
      \ 'depends': ['Shougo/unite.vim'],
      \ 'autoload': {
      \ 'unite_sources': ["outline"],
      \ }}
NeoBundle 'Shougo/vimfiler'
NeoBundleLazy 'tsukkee/unite-tag', { 'autoload' : {'unite_sources' : 'tag' }}       

" 神器
NeoBundle 'surround.vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'haya14busa/vim-migemo'
NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {'insert' : '1'} }
NeoBundle 'scrooloose/syntastic'  

" クールすぎる見た目   
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Yggdroot/indentLine'

" git
NeoBundle 'tpope/vim-fugitive'

" ruby
NeoBundleLazy 'vim-ruby/vim-ruby',{ 'autoload':{ 'filetypes': 'ruby'}} 
NeoBundleLazy 'tpope/vim-endwise',{ 'autoload':{ 'filetypes': 'ruby'}} 
NeoBundleLazy 'tpope/vim-rails',{ 'autoload':{ 'filetypes': 'ruby'}} 
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': 'Shougo/vimproc',
      \ 'autoload' : {
      \ 'commands': ['TagsUpdate', 'TagsSet', 'TagsBundle']
      \ }}
" javascript
NeoBundleLazy 'jiangmiao/simple-javascript-indenter',{'autoload': { 'filetypes': ['javascript'] }}
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{ 'filetypes':['javascript'] }}
NeoBundleLazy 'marijnh/tern_for_vim', { 'build': { 'others': 'npm install' }}
" markdown
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'hokaccha/vim-html5validator'

"html
NeoBundle 'othree/html5.vim'
NeoBundle 'mattn/emmet-vim'

" colorscheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'sjl/badwolf'
NeoBundle 'vim-scripts/summerfruit256.vim'

" coffee script
NeoBundle 'kchmck/vim-coffee-script'

" 一括コメントアウト
NeoBundle "tyru/caw.vim.git"
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

call neobundle#end()

filetype plugin indent on
syntax enable
NeoBundleCheck

colorscheme molokai

" =======================================
" Edit
" =======================================

nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>,  :<C-u>source $MYVIMRC<CR> 

nnoremap [vim] <Nop>
nmap <Space>v [vim]
nnoremap [vim]g :<C-u>edit $MYGVIMRC<CR>
nnoremap [vim]rg :<C-u>source $MYGVIMRC<CR> 

" set autoindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
au FileType * setlocal formatoptions-=o
set autoread
set infercase
set virtualedit=all

set modeline
set showmatch 
set matchtime=1
set backspace=indent,eol,start
"set cpoptions-=m
set matchpairs& matchpairs+=<:>
set hidden
set switchbuf=useopen

" do not create backup
set nowritebackup
set nobackup
set noswapfile

set tags+=tags,./tags,.git/*.tags
set wrapscan 
set ignorecase
set smartcase
set incsearch
set nohlsearch

" 編集履歴を保存して終了する
if has('persistent_undo') && isdirectory($HOME.'/.vim/undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 最後に編集した場所にカーソルを移動する
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" 常にファイルの位置をカレントディレクトリに
if has("unix")
  augroup MyAutoCmd
    autocmd! 
    au BufRead,BufNewFile * execute ":lcd" . expand("%:p:h")
  augroup END
endif

" クリップボードは常にレジストリ
set clipboard^=unnamed,autoselect
"if has('unix') || has('kaoriya')
if has("clipboard") 
  vmap ,y "+y 
  nmap ,p "+gP 
  " exclude:{pattern} must be last ^= prepend += append 
  if has("gui_running") || has("xterm_clipboard") 
    silent! set clipboard^=unnamedplus 
    set clipboard^=unnamed 
  endif 
endif           

" =======================================
" KeyMap
" =======================================

" 選択
noremap j gj
noremap k gk
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ <S-a><Esc>
noremap  $ g$
vnoremap v $h
nnoremap <C-h><C-h> :nohlsearch<CR><Esc>
noremap <Space>w <C-w>
nnoremap <C-]> g<C-]>
"search center
nnoremap n nzz
nnoremap N Nzz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap G Gzz
nnoremap <C-o> <C-o>zz

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" ファイルを整形
function! s:format_file()
  let view = winsaveview()
  normal gg=G
  silent call winrestview(view)
endfunction
nnoremap <Space>i :call <SID>format_file()<CR>


" =======================================
" Display
" =======================================

" chenge background color for solarized  
nnoremap ,bl :<C-u>set background=light<CR> 
nnoremap ,bd :<C-u>set background=dark<CR> 

set splitbelow
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
set background=dark
syntax on
set title
set number
set wrap
"補完時の一覧表示有効化
set wildmenu wildmode=list:full 
set textwidth=0 " 自動的な改行無効
set colorcolumn=80 " 80行目にライン
set showcmd
" set cursorline
set showmode
set scrolloff=5 " 5行余裕を持ってスクロール
set history=200
set showfulltag
set wildoptions=tagfile
" Always show the statusline
set laststatus=2
set splitbelow
set splitright
set ambiwidth=double
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
" setlistchars=tab:≫-,trail:-,extends:≫,precedes:≪,nbsp:%,eol:?
" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>+<CR>
nnoremap <S-Down>  <C-w>-<CR>

" Tab {{{
set showtabline=2 
" prefix key
nnoremap [Tag] <Nop>
nmap t [Tag]
nnoremap <silent> [Tag]c :tablast <bar> tabnew<CR>
nnoremap <silent> [Tag]l :tabnext<CR>
nnoremap <silent> [Tag]h :tabprevious<CR>
"}}}

" Style {{{
if !has('gui_running')
  set t_Co=256
  set background=light
  colorscheme molokai 
  highlight Pmenu ctermbg=2
  highlight PmenuSel ctermbg=3
  highlight ColorColumn ctermbg=0 guibg=darkgray
  highlight Error term=undercurl cterm=undercurl gui=undercurl ctermfg=1 ctermbg=0 guisp=Red
  highlight Warning term=undercurl cterm=undercurl gui=undercurl ctermfg=4 ctermbg=0 guisp=Blue
  highlight qf_error_ucurl term=undercurl cterm=undercurl gui=undercurl guisp=Red
  highlight qf_warning_ucurl term=undercurl cterm=undercurl gui=undercurl guisp=Blue
endif
"}}}

" =======================================
" Unite
" =======================================

nnoremap [unite] <Nop>
nmap <Space>f [unite]
" 高速化
let g:unite_source_file_mru_filename_format = ''
" start insert mode
let g:unite_enable_start_insert = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_grep_encoding='utf-8'
" buffer
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" file
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
"open resen tfile
nnoremap <silent> [unite]m :<C-u>Unite -create file_mru<CR>
" unite outline
nnoremap <silent> [unite]o :<C-u>Unite -create outline -buffer-name=search -auto-highlight -no-start-insert<CR>

"ユナイトビューティフルアタック！！
nnoremap <silent> [unite]z :<C-u>Unite colorscheme -auto-preview<CR>
" レジストリ
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" yankroundの履歴
nnoremap <silent> [unite]y :<C-u>Unite yankround<CR>

" アウトライン表示
nnoremap <silent> ;o
      \ :<C-u>Unite -no-focus -no-quit -vertical -winwidth=35 -no-start-insert -here -create -toggle outline<CR>
" uniteで検索
nnoremap <silent> g/ :<C-u>Unite -buffer-name=search line:forward -start-insert -auto-highlight<CR>

"  augroup END
augroup MyAutoCmd
  autocmd!
  autocmd FileType unite call s:unite_my_settings()
augroup END

function! s:unite_my_settings()
  imap <silent> <buffer> <ESC><ESC> <ESC>q
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction

"au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
"au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" =======================================
" neosnippet
" =======================================

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-l> <Plug>(neosnippet_start_unite_snippet_target)
"if has('conceal')
"set conceallevel=2 concealcursor=i
"endif

" =======================================
" neocomplete 
" =======================================

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Enable at startup
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Enable _ separated completion
let g:neocomplete_enable_underbar_completion = 1
" length need to start completion  
let g:neocomplete#auto_completion_start_length = 2
" あいまい検索
let g:neocomplete#enable_fuzzy_completion = 1
" キャメルケース選択
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#manual_completion_start_length = 0
" 3文字からキャッシュ
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Set minimum syntax keyword length.
let g:neocomplete#min_keyword_length = 2
let g:neocomplete#enable_prefetch = 1


let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'javascript': $HOME.'/Dropbox/dist/javascript.dist'
      \ }
" キャッシュしないファイル名
let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'
" 自動補完を行わないバッファ名
let g:neocomplete#lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" omni1 補完を有効にする
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

"インクルード文のパターンを指定
let g:neocomplete#include_patterns = {
      \ 'ruby' : '^\s*require',
      \ 'javascript' : '^\s*require',
      \ 'coffee' : '^\s*require',
      \ }

"インクルード先のファイル名の解析パターン
let g:neocomplete#include_exprs = {
      \ 'ruby' : substitute(v:fname,'::','/','g')
      \ }

" ファイルを探す際に、この値を末尾に追加したファイルも探す。
let g:neocomplete#include_suffixes = {
      \ 'ruby' : '.rb',
      \ }

" =======================================
" VimFiler
" =======================================

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap  <silent><Space>e :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap  <silent><Space>E :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>et g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap  <silent><Space>e :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap  <silent><Space>E :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>


" =======================================
" VimShell
" =======================================
noremap ,v :VimShellBufferDir<CR>
nnoremap <silent> vp :cd %:h<CR>:VimShellPop<CR>
nnoremap vs :VimShellBufferDir -split<CR>
" デフォルトのコンテキストを-prompt-direction=topにする
call unite#custom#profile('default', 'context', { 'prompt_direction': 'top'})

" =======================================
" LightLine
" =======================================

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode'
      \ }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" =======================================
" Plugin
" Settig
" =======================================

" yankround {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
" }}}

" function neobundle#autoload#command 処理中にエラー
" 以下13行をコメントアウトするとエラーが発生しない
" AlpacaTagsa {{{
" if has("unix")
"   augroup AlpacaTags
"     autocmd!
"     if exists(':Tags')
"       au BufWritePost Gemfile TagsBundle
"       au BufEnter * TagsSet
"       au BufWritePost * TagsUpdate
"       " au BufEnter,BufRead,BufNewFile *.rb NeoCompleteTagMakeCache
"     endif
"   augroup END
" endif
" }}}

" rubyで%移動 {{{
if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif
" }}}

" surround.vim {{{
nmap <C-s> ysW"
nmap " cs'"
nmap ' cs"'
" }}}

" rubycomplete.vim {{{
au FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_rails = 0
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_object_space = 1
let ruby_operators = 1
" }}}
