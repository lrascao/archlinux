" vim:foldmethod=marker:foldlevel=0
" Luis Rascao

" auto-install vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
"  }}}
"
" Global {{{
set nocompatible        " don't bother trying to pretend you're vi
" }}}
"
" Colors {{{
syntax enable			" enable syntax highlighting
colorscheme peaksea		" located at ~/.vim/colors, other good ones, solarized, molokai
                        " install new colour scheme vim files at ~/.vim/colors
set termguicolors 		" terminal vim will use full 24-bit colors
set background=dark
" molokai: curl -fLo ~/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
" peaksea: curl -fLo ~/.vim/colors/peaksea.vim --create-dirs https://raw.githubusercontent.com/vim-scripts/peaksea/master/colors/peaksea.vim
"  }}}
"
"  Misc {{{
set backspace=indent,eol,start	" makes backspace work like in other programs
set wildignore=.git,.git/*
"  }}}
"
" Spaces & Tabs {{{
set tabstop=4       		" number of visual spaces per TAB
set softtabstop=4   		" number of spaces in tab when editing
set expandtab       		" tabs are spaces
set shiftwidth=4		    " an indent to correspond to a single tab
set modelines=1			    " modelines allow you to set variables specific to a file as a header at the top
filetype indent on	        " This both turns on filetype detection and allows loading of
				            " language specific indentation files based on that detection
filetype plugin on
set autoindent			    " does nothing more than copy the indentation from the previous line, when starting a new
				            " line
" }}}
"
" UI Layout {{{
let loaded_matchparen = 1   " disable the default behaviour to match parenthesis when navigating
set showcmd             	" show last command entered in bottom bar
set nocursorline          	" highlight current line
set lazyredraw              " redraw only when we need to.
set showmatch               " higlight matching parenthesis
set mat=2                   " How many tenths of a second to blink when matching brackets
"set fillchars+=vert:|       " Characters to fill the statuslines and vertical separators.
set foldcolumn=1            " Add a bit extra margin to the left
set encoding=utf8           " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac        " Use Unix as the standard file type
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" }}}
"
" Files, backups and undo {{{
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//
" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.vim/backup//
end
" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//
" }}}
"
" Searching {{{
set path+=**                " Search down into subfolders, provides tab-completion for all file-related tasks
set wildmenu			    " it will provide a graphical menu of all the matches you can cycle through 
set ignorecase              " ignore case when searching
set incsearch               " search as characters are entered
set hlsearch                " highlight all matches
set smartcase               " When searching try to be smart about cases 
nnoremap <leader><space> :nohlsearch<CR>
" This rewires n and N to do the highlighing...
highlight WhiteOnRed ctermbg=red ctermfg=white
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>
" }}}
"
" Folding {{{
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=indent       " fold based on indent level,
                            " Other acceptable values are marker, manual, expr, syntax, diff.
                            " Run :help foldmethod
" space open/closes folds
nnoremap <space> za
" }}}
"
" Sounds {{{
set noerrorbells
set novisualbell
set t_vb=
" }}}
"
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
" }}}
"
" Leader Shortcuts {{{
let mapleader=","
" jk is escape (only on insert mode)
inoremap jk <esc>
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" }}}
"
" Copy/Paste {{{
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" do not clobber default register on paste
vnoremap p "0p
vnoremap P "0P
" }}}
"
" Browsing with netrw {{{
let g:netrw_banner = 0          " remove the banner
let g:netrw_liststyle = 3       " tree style
let g:netrw_browse_split = 3    " open files in a new tab
let g:netrw_winsize = 25        " file explorer width percentage
" }}}
"
" Tmux {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    " set term=xterm-256color
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
"
" Misc {{{
" no delays, timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays
set timeoutlen=300 ttimeoutlen=0
"====[ Open any file with a pre-existing swapfile in readonly mode "]=========
" augroup NoSimultaneousEdits
"     autocmd!
"     autocmd SwapExists * let v:swapchoice = 'o'
"     autocmd SwapExists * echomsg ErrorMsg
"     autocmd SwapExists * echo 'Duplicate edit session (readonly)'
"     autocmd SwapExists * echohl None
"     autocmd SwapExists * sleep 2
" augroup END
" }}}
"
" Plugins below
"
"
" Vim Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'maxboisvert/vim-simple-complete'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elixir-editors/vim-elixir'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jjo/vim-cue'
call plug#end()
" }}}
"
 " airline {{{
set laststatus=2
let g:airline_theme = 'luna'
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_section_c = '%-0.32{getcwd()}\%t'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
" }}}
"
"
" vim-surround {{{
nmap <silent> "" :call Toggle_Surround('"')<cr>
nmap <silent> '' :call Toggle_Surround('''')<cr>
" }}}
"
"
" syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}
"
"
" rust.vim {{{
let g:syntastic_rust_checkers = ['cargo']
" }}}
"
"
" vim-simple-complete {{{
set complete-=t
set complete-=i
" }}}
"
"
" ctrlp {{{
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<C-e>'],
    \ 'AcceptSelection("t")': ['<Cr>'],
    \}
" }}}
"
"
" Helper functions
"
"
" toggle surround of selection
function! Toggle_Surround(char)
  let pos = getcurpos()
  let cur = col(".")
  exe "norm! va".a:char
  let start = col("v")
  let end = col(".")
  exe "norm! \<esc>"
  call cursor(pos[1], pos[2])
  if start <= cur && cur <= end && start != end
    " inside quote :)
    exe "norm ds".a:char
    call cursor(pos[1], pos[2]-len(a:char))
  else
    " not inside a quote
    " hapens when cur <= start or end <= cur_sol or cur == start == end
    exe "norm ysiw".a:char
    call cursor(pos[1], pos[2]+len(a:char))
  endif
endfunction

" highlight next match
" OR ELSE just highlight the match in red...
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

