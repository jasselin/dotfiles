" Plugins
    call plug#begin()

    " Themes
    Plug 'dracula/vim', { 'as': 'dracula' }

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/tagbar'

    " Vimwiki
    Plug 'vimwiki/vimwiki'
    Plug 'tools-life/taskwiki'

    " Language support
    Plug 'pangloss/vim-javascript'
    Plug 'plasticboy/vim-markdown'
    Plug 'leafgarland/typescript-vim'

    call plug#end()

" Appearance
    if (has("termguicolors"))
        set termguicolors
    endif

    syntax on
    color dracula
    let g:airline_theme='dracula'

" Other configs
    set nobackup
    set nowritebackup
    set noswapfile

    set nocompatible
    filetype plugin indent on
    set tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab
    set incsearch ignorecase smartcase hlsearch
    set wildmode=longest,list,full wildmenu wildignore=*.swp,*.bak
    set ruler laststatus=2 showcmd showmode
    set nowrap
    set autoindent
    set hidden " Hides buffer instead of unloading
    set number " Line numbers
    set cursorline
    set title  " File in title bar
    set updatetime=300 " Faster refresh
    set clipboard=unnamed

" Key mappings
    let mapleader = ","

    nmap <silent> <leader><leader> :noh<CR>
    nmap <C-Tab> :tabnext<CR>
    nmap <C-S-Tab> :tabprevious<CR>
    nnoremap ; :

" NERDTree
    map <C-n> :NERDTreeToggle<CR>

" NERDCommenter
    nmap <C-k> <Plug>NERDCommenterToggle
    vmap <C-k> <Plug>NERDCommenterToggle<CR>gv

" Tagbar
    nmap <leader>b :TagbarToggle<CR>
    let g:tagbar_width = 30

" vimrc shortcut and autoreload
    map <leader>vimrc :tabe ~/dotfiles/vim/.vimrc<CR>
    autocmd bufwritepost init.vim source $MYVIMRC

" vim-markdown
    let g:markdown_fenced_languages = ['javascript', 'bash', 'css']

" vimwiki
    let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
    let g:vimwiki_global_ext = 0
    let g:vimwiki_diary_header = 'Journal'
    let g:vimwiki_diary_months = {
        \ 1: 'Janvier', 2: 'Février', 3: 'Mars',
        \ 4: 'Avril', 5: 'Mai', 6: 'Juin',
        \ 7: 'Juillet', 8: 'Août', 9: 'Septembre',
        \ 10: 'Octobre', 11: 'Novembre', 12: 'Décembre'
        \ }

" Commands
    " Remaps common typos
    :command WQ wq
    :command Wq wq
    :command W w
    :command Q q

" Fixes for French-Canadian keyboard layout
    nnoremap ? ^
    nnoremap é ?
