"---------------------------------------------------------------------------
" For UNIX:
"

set shell=zsh

" Set path.
let $PATH = expand('~/bin').':/usr/local/bin/:'.$PATH

if has('gui_running')
  finish
endif

"---------------------------------------------------------------------------
" For CUI:
"


if !has('nvim')
  set term=xterm-256color

  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! s:XTermPasteBegin(ret) abort
    setlocal paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ s:XTermPasteBegin('0i')
  inoremap <special> <expr> <Esc>[200~ s:XTermPasteBegin('')
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>

  " Change cursor shape.
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[0 q"

  " italic
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
endif

" Enable true color
if exists('+termguicolors')
  set termguicolors
endif

" Disable the mouse.
set mouse=

" Colorscheme
colorscheme onedark
set background=dark
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
