syntax on
set title
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set number
set relativenumber
set cursorline
highlight CursorLine cterm=bold term=bold guibg=Grey40

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
au BufNewFile,BufRead Jenkinsfile setf groovy
