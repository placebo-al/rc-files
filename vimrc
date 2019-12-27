" Vimrc 
set nocompatible
syntax on		" enable syntax processing
set mouse=a     " Enable use of the mouse for all modes
" set mouse=v     " Enable use of the mouse to copy and paste
set novisualbell    " Disable visual error warning 
set noerrorbells  " Disable the continuous beep   
" set lazyredraw  " An attempt to speed up scrolling
set backspace=indent,eol,start

" Colours
colorscheme desert            "Trying a new colourscheme

" Spaces and Tabs
set tabstop=4       	" number of visual spaces per TAB
set softtabstop=4   	" number of spaces in tab when editing
set expandtab       	" tabs are spaces
set shiftwidth=4        " sets the indent to 4 spaces
set smarttab

" UI Config
set showcmd		    " show command in bottom bar
filetype indent on 	" load filetype-specific indent files
filetype plugin on  " load filetype-specific plugin files
set wildmenu		" visual autocomplete for command menu
set showmatch           " highlight matching [{()}]

" Folding
set foldenable 		" enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za	" use space instead of 'za' to to undo folds
" set foldmethod=indent	" fold based on indent level
