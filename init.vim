let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/.vim/plugged'))
" Colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'AlessandroYorba/Alduin'
Plug 'wojciechkepka/vim-github-dark'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'szw/vim-maximizer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'elixir-editors/vim-elixir'
Plug 'janko/vim-test'
Plug 'preservim/nerdtree'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'voldikss/vim-floaterm'

" lsp
Plug 'neovim/nvim-lspconfig'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'

" VSnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Emmet
Plug 'mattn/emmet-vim'
call plug#end()

" defaults
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set cursorline
set mouse=a " if I accidentally use the mouse
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set relativenumber
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set nobackup " don't create backup files
set nowritebackup " don't create backup files
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. LSP, ...)
set updatetime=520 " time until update
set undofile " persists undo tree
filetype plugin indent on " enable detection, plugins and indents
set tabstop=2
set shiftwidth=2
set expandtab
set ai " autoindent
set smartindent
let mapleader = " " " space as leader key
let g:netrw_banner=0 " disable banner in netrw
let g:netrw_liststyle=3 " tree view in netrw
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown
nnoremap <leader>v :e $MYVIMRC<CR>

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

" material theme variation
" default | palenight | ocean | lighter | darker
let g:material_theme_style = 'darker'

set bg=dark
colorscheme material

set encoding=utf-8

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extentions#branch#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '

set clipboard=unnamedplus

" Which-Key setup
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" LSP Config
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

nvim_lsp.tsserver.setup { }
nvim_lsp.elixirls.setup{
    cmd = { "/Users/jwstover/.local/bin/elixir-ls/rel/language_server.sh" },
    on_attach = on_attach
}
EOF

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>N :NERDTree<CR>

" vim maximizer
nnoremap <leader>m :MaximizerToggle!<CR>

" windows & navigation
nnoremap <leader>wv :vs<CR>
nnoremap <leader>wh :sv<CR>

" commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" Telescope
lua <<EOF
local actions = require('telescope.actions')require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}
EOF
nnoremap <leader>fd <cmd>Telescope file_browser<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><space> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>si <cmd>Telescope treesitter<cr>

" vim-test
nnoremap <leader>tt :TestVisit<CR>
nnoremap <leader>ts :TestNearest<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tr :TestLast<CR>

"-- FOLDING --  
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=1 "defines 1 col at window left, to indicate folding  
let javaScript_fold=1 "activate folding by JS syntax  
set foldlevelstart=99 "start file with all folds opened

" floaterm
nnoremap <leader>ot :FloatermToggle<CR>
nnoremap <leader>oT :FloatermNew<CR>
nnoremap <leader>fd :FloatermNew ranger<CR>


" turn off fold gutter
set foldcolumn=0

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"css", "elixir", "hcl", "heex", "html", "java", "javascript", "json", "lua", "typescript", "tsx", "vim", "yaml"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" nvim-cmp
set completeopt=menu,menuone,noselect

lua <<EOF
-- Setup nvim-cmp.
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body)
  end,
  },
mapping = {
  ['<C-p>'] = cmp.mapping.select_prev_item(),
  ['<C-n>'] = cmp.mapping.select_next_item(),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ['<CR>'] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
    },
  ['<Tab>'] = function(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    -- elseif luasnip.expand_or_jumpable() then
    --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
  else
    fallback()
  end
end,
['<S-Tab>'] = function(fallback)
if vim.fn.pumvisible() == 1 then
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
elseif luasnip.jumpable(-1) then
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
else
  fallback()
end
end,
},
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    },
  }
EOF

" terminal
tmap <C-o> <C-\><C-n>
tmap <C-h> <C-\><C-n>:FloatermHide<CR>

" Emmet
autocmd FileType html,htmldjango,css,scss,sass,eelixir imap <expr> <C-J> "\<Plug>(emmet-expand-abbr)"


set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic gui=italic

let g:markdown_fenced_languages = ['elixir']
