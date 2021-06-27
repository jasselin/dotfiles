" Plugins
    call plug#begin()

    " Themes
    Plug 'dracula/vim', { 'as': 'dracula' }

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/tagbar'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" CoC
    set cmdheight=2
    set shortmess+=c

    if has("nvim-0.5.0") || has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
    else
        set signcolumn=yes
    endif

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Tagbar
    nmap <leader>b :TagbarToggle<CR>
    let g:tagbar_width = 30

" vimrc shortcut and autoreload
    map <leader>vimrc :tabe $MYVIMRC<CR>
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
