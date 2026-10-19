syntax enable
set number
set relativenumber
set ruler
set ignorecase
set smartcase
set incsearch
set hlsearch
set scrolloff=5
set wildmenu

filetype on
augroup markdown_wrap
  autocmd!
  autocmd FileType markdown setlocal wrap linebreak
  autocmd FileType markdown setlocal textwidth=80 formatoptions+=t
augroup END

