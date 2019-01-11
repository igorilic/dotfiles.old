set nocompatible
set encoding=utf-8
scriptencoding utf-8
filetype off
au BufWritePost ~/.vimrc so ~/.vimrc


" python provider setting for ultinsnips
let g:loaded_python_provider = 1
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'


" Ruby exec
" /usr/local/bin/neovim-ruby-host
let g:ruby_host_prog = '/usr/local/bin/neovim-ruby-host'

call plug#begin()
" Colors and themes
Plug 'junegunn/limelight.vim'
Plug 'haishanh/night-owl.vim'
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
" File system helpers
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomtom/tcomment_vim' " toggle comments <LEADER>__
" Javascript
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst' " ejs syntax highlight
" React and JSX
Plug 'mxw/vim-jsx'
Plug 'valloric/MatchTagAlways'
Plug 'flowtype/vim-flow'

" suntax
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'mattn/emmet-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:deoplete#enable_at_startup = 1

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript',       { 'do': ':UpdateRemotePlugins' }

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

Plug 'burnettk/vim-angular'
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-node'
Plug 'Raimondi/delimitMate'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'styled-components/vim-styled-components'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'dietsche/vim-lastplace'
Plug 'suan/vim-instant-markdown'
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install'}

" latex
Plug 'lervag/vimtex'
Plug 'ajh17/VimCompletesMe'

call plug#end()

" tweaks
let g:vimtex_compiler_progname = 'nvr'

" Prettier on save
autocmd BufWritePre *.js Neoformat

augroup ultisnips_no_auto_expansion
  au!
  au VimEnter * au! UltiSnips_AutoTrigger
augroup END

" settings
let mapleader = "'"
set nobackup
set nowritebackup
set noswapfile
"set guifont=Menlo\ 10
set showcmd
set autoread
au FocusGained,BufEnter * :silent! !


set laststatus=2
filetype plugin on
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set autoindent
set autoread

" Toggle Comments {{{
augroup TOGGLE_COMMENTS
  au!
  au BufNewFile,BufFilePre,BufRead * if !exists ('b:comment_leader') |
                                    \   let b:comment_leader = 'k ' |
                                    \ endif

  au FileType c,cpp,java,scala          let b:comment_leader = '// '
  au FileType javascript                let b:comment_leader = '// '
  au FileType zsh,sh,ruby,python        let b:comment_leader = '# '
  au FileType conf,fstab                let b:comment_leader = '# '
  au FileType tex                       let b:comment_leader = '% '
  au FileType mail                      let b:comment_leader = '> '
  au FileType vim                       let b:comment_leader = '" '
augroup END

function! s:search_store()
  let s:ps = getreg('/', 1)
  let s:ps_t = getregtype('/')
endfunction

function! s:search_restore()
  if !(exists('s:ps') && exists('s:ps_t'))
    return
  endif

  call setreg('/', s:ps, s:ps_t)
endfunction

noremap <silent> g> <esc>:call <sid>search_store()<cr>:<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<cr>/<cr>:noh<cr>:call <sid>search_restore()<cr>
noremap <silent> g< <esc>:call <sid>search_store()<cr>:<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<cr>//e<cr>:noh<cr>:call <sid>search_restore()<cr>
xnoremap <silent> g> <esc>:call <sid>search_store()<cr>gv:<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<cr>/<cr>:noh<cr>:call <sid>search_restore()<cr>gv
xnoremap <silent> g< <esc>:call <sid>search_store()<cr>gv:<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<cr>//e<cr>:noh<cr>:call <sid>search_restore()<cr>gv
" }}}

" Prettier setup
nmap <Leader>q <Plug>(Prettier)
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_coma = 'all'

inoremap <C-a> </<C-X><C-O>
let g:enable_bold_font = 1
" autocompletion
inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O

"ts
au BufRead,BufNewFile *.ts setlocal filetype=typescript
set rtp+=/home/igor/.vim/plugged/typescript-tools.vim/

" js
let g:used_javascript_libs = 'angularjs,angularui, angularuirouter,requirejs'

" vim css3
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END
" nerdtree config
map <Leader>t :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" md
let g:instant_markdown_slow = 1
let g:mardown_fensed_languages = ['html', 'javascript']

" Tern
let g:tern_map_keys=1
let g:tern_show_argument_hints='on hold'

" Goyo
let g:goyo_width = 80
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
let g:limelight_default_coefficient = 0.3

function! s:goyo_enter()
 "" silent !tmux set status off
 "" silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  "silent !tmux set status on
  "silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <Leader>r :Goyo<CR>

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set cursorline
vnoremap < <gv
vnoremap > >gv
nnoremap j gj
nnoremap k gk
noremap <silent><Leader>/ :nohlsearch<CR>
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

if exists('+colorcolumn')
	set colorcolumn=80
else
	autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

nmap <leader>o :echo 'Obsolete: use ]\<Space\> from vim-unimpaired'<Cr>
nmap <leader>O :echo 'Obsolete: use [\<Space\> from vim-unimpaired'<Cr>

set matchpairs+=«:»
set matchpairs+=‹:›
set matchpairs+=“:”
set matchpairs+=‘:’
set matchpairs+=►:◄

set clipboard=unnamedplus
set backspace=2
set hlsearch

set incsearch
set ignorecase
set smartcase
set scrolloff=2
set history=1000
set ruler
syntax on
syntax enable
if (has("termguicolors"))
  set termguicolors
endif
colorscheme night-owl
"FONT
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic
hi Type gui=italic cterm=italic
set showmatch

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

" snippets
imap <C-k>	<Plug>(neosnippet_expand_or_jump)
smap <C-k>	<Plug>(neosnippet_expand_or_jump)
xmap <C-k>	<Plug>(neosnippet_expand_target)


let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

nnoremap U :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_preview_height = 20
xnoremap <leader>p "0p

set breakindent
set linebreak
set showbreak=…
set formatoptions+=l

nnoremap <silent> <Leader>f :FZF<CR>
function! s:buflist()
  redir => ls
  silent ls

  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> gb :call fzf#run({
		\   'source':  reverse(<sid>buflist()),
	\   'sink':    function('<sid>bufopen'),
	\   'options': '+m',
	\   'down':    len(<sid>buflist()) + 2
	\ })<CR>

let g:NumberToggleTrigger="<leader>n"

set number
set numberwidth=5
set rnu
function! ToggleNumbersOn()
  set nu!
  set rnu
endfunction
function! ToggleRelativeOn()
  set rnu!
  set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()




nnoremap <leader>N :set nonumber<Cr>
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-w> :TmuxNavigateLeft<cr>

nnoremap <leader>gb :Gblame<Cr>
nnoremap <leader>gs :Gstatus<Cr>
nnoremap <leader>gc :Gcommit<Cr>
nnoremap <leader>gl :Glog<Cr>
nnoremap <leader>gw :Gwrite<Cr>
nnoremap <leader>gd :Gvdiff<Cr>
let g:auto_save = 0
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>
set fencs=utf8,cp1254,latin1
set infercase
set shiftround
set wildmenu
set wildmode=list:longest,full
set ttyfast
set list listchars=tab:»·,trail:·,nbsp:·
set textwidth=100
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1
set splitright
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999
set backup
set backupskip=
set backupdir=.
set nostartofline
set fo+=r
set splitright
set shell=zsh
set cb=unnamed

" TYPESCRIPT
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces

let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_settings = {
  \ 'javascript.jsx': {
    \  'extends': 'jsx',
    \ },
  \ }

" JSX indentation in js files
let g:jsx_ext_required = 0

" Vimtex
" let g:vimtex_disable_version_warning = 1
" if !exists('g:deoplete#omni#input_patterns')
"       let g:deoplete#omni#input_patterns = {}
"   endif
"   let g:deoplete#omni#input_patterns.tex = '\\(?:'
"         \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
"         \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
"         \ . '|hyperref\s*\[[^]]*'
"         \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"         \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
"         \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"         \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
"         \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
"         \ .')'
" 
" if !exists('g:neocomplete#sources#omni#input_patterns')
"     let g:neocomplete#sources#omni#input_patterns = {}
"   endif
"   let g:neocomplete#sources#omni#input_patterns.tex =
"         \ '\v\\%('
"         \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"         \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
"         \ . '|hyperref\s*\[[^]]*'
"         \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"         \ . '|%(include%(only)?|input)\s*\{[^}]*'
"         \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"         \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
"         \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
"         \ . ')'
" augroup VimCompletesMeTex
" 	autocmd!
" 	autocmd FileType tex let b:vcm_omni_pattern = <neocomplete-pattern>
" augroup END

" if !exists('g:ycm_semantic_triggers')
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.tex = [
"       \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
"       \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
"       \ 're!\\hyperref\[[^]]*',
"       \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
"       \ 're!\\(include(only)?|input){[^}]*',
"       \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
"       \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
"       \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
"       \ ]
" LightLine
let g:lightline = {
	\ 'colorscheme': 'night-owl',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 		  [ 'fugitive', 'filename' ] ]
	\ },
	\ 'component_function': {
	\ 	'fugitive': 'LightLineFugitive',
	\ 	'readonly': 'LightLineReadOnly',
	\ 	'modified': 'LightLineModified',
	\ 	'filename': 'LightLineFilename'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }
function! LightLineFilename()
  let git_root = fnamemodify(fugitive#extract_git_dir(expand("%:p")), ":h")
  if expand("%:t") == ""
    return "[No Name]"
  elseif git_root != "" && git_root != "."
    return substitute(expand("%:p"), git_root . "/", "", "")
  else
    return expand("%:p")
  endif
endfunction

function! LightLineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return ""
	else
		return ""
	endif

endfunction
function! LightLineModified()
	if &filetype == "help"
		return ""
	elseif &modifed
		return "+"
	elseif &modifiable
		return ""
	else
		return ""
	endif
endfunction
function! LightLineFugitive()
	if exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? ' '._ : ''
	endif
	return ''
endfunction

" Linting
let g:ale_linters = {
\  'javascript.jsx': ['eslint'],
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0

" Codi
function! s:pp_js(line)
  " Strip escape codes
  return substitute(a:line, "\<esc>".'\[\d\(\a\|\dm\)', '', 'g')
endfunction

" MatchTagAlways to highlight JSX
let g:mta_filetypes = {
    \ 'javascript.jsx' : 1,
    \}
