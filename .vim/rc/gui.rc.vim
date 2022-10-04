"---------------------------------------------------------------------------
" GUI:
" Mac or Linux

"---------------------------------------------------------------------------
" Fonts: "{{{
set ambiwidth=double

if has('mac') " For Mac.
   set guifont=Osaka－等幅:h14
else " For Linux.
   set guifontwide=VL\ Gothic\ 13
   set guifont=Courier\ 10\ Pitch\ 14
endif"}}}

"---------------------------------------------------------------------------
" Window:"{{{
if &columns < 170
    " Width of window.
   set columns=170
endif
if &lines < 40
  " Height of window.
   set lines=40
endif

" Don't override colorscheme.
if !exists('g:colors_name')
  colorscheme candy
endif
"}}}

"---------------------------------------------------------------------------
" Options:"{{{
set mouse=
set mousemodel=

" Don't focus the window when the mouse pointer is moved.
set nomousefocus
" Hide mouse pointer on insert mode.
set mousehide

" Hide toolbar and menus.
set guioptions-=Tt
set guioptions-=m
" Scrollbar is always off.
set guioptions-=rL
" Not guitablabel.
set guioptions-=e
" Confirm without window.
set guioptions+=c

" Don't flick cursor.
set guicursor&
set guicursor+=a:blinkon0
"}}}

" vim: foldmethod=marker

set background=dark
colorscheme sourcerer
