set nocompatible
filetype plugin indent on
let python_highlight_all=1
syntax on
set hidden
set relativenumber
set number
set background=dark
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set t_Co=256
set noswapfile
set splitright
set foldlevel=99
set exrc
set secure
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
set signcolumn=yes
set updatetime=300
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set ignorecase
set smartcase

let g:nvim_config_root = stdpath('config')
let g:vimrc = g:nvim_config_root . '/init.vim'
let $MYVIMRC = g:vimrc
let g:plugged = stdpath('data').'/plugged'
let g:plug_path = stdpath('data') . '/site/autoload/plug.vim'

" Install vim-plug
if empty(glob(g:plug_path))
  silent !curl -fLo g:plug_path --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source g:vimrc
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'morhetz/gruvbox'

Plug 'folke/trouble.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'j-hui/fidget.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'm-demare/hlargs.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/rust-tools.nvim'
Plug 'weilbith/nvim-code-action-menu'
Plug 'williamboman/nvim-lsp-installer'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'prabirshrestha/vim-lsp'
Plug 'Shougo/deoplete.nvim'
Plug 'lighttiger2505/deoplete-vim-lsp'

Plug 'github/copilot.vim'

call plug#end()
"Enable deoplete at startup
" let g:deoplete#enable_at_startup = 1

let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors = 256
colorscheme gruvbox

lua require('init')


inoremap jk <Esc>
" Uppercase whole word in insert mode
inoremap <c-u> <esc>gUiwi
" Uppercase whole word in normal mode
nnoremap <c-u> gUiw

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
cnoremap w!! w !sudo tee > /dev/null %

noremap <leader>so :w<cr>:so %<cr>

" Window movement
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Termianl window movement
tnoremap <C-j> <C-\><C-N> <C-W>j
tnoremap <C-k> <C-\><C-N> <C-W>k
tnoremap <C-h> <C-\><C-N> <C-W>h
tnoremap <C-l> <C-\><C-N> <C-W>l

" Disable scrolling
inoremap <ScrollWheelUp> <Nop> 
inoremap <ScrollWheelDown> <Nop> 

" Tab mappings
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove<cr>
noremap <leader>tN :tabNext<cr>
noremap <leader>tp :tabprevious<cr>
noremap <leader>tom :tabnew<cr>:vsplit<cr><C-W>h:split<cr>

" Search
noremap <silent> <leader><cr> :noh<cr>

" Telescope
    " Using Lua functions
nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Rust development
noremap <leader>ct :!cargo test<cr>
let g:rustfmt_autosave = 1

" ------------------------------------
" j-hui/fidget.nvim
" ------------------------------------
"
lua require("fidget").setup()
" ------------------------------------
" kosayoda/nvim-lightbulb
" ------------------------------------
"
autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
" ------------------------------------
" weilbith/nvim-code-action-menu
" ------------------------------------
"
let g:code_action_menu_window_border = 'single'
" ------------------------------------
" folke/trouble.nvim
" ------------------------------------
"
lua require("trouble").setup()
" ------------------------------------
" Neovim LSP
" ------------------------------------
"
"  lsp installer
"  ----------------------------------
lua require("nvim-lsp-installer").setup {}
"
"  CCLS
"  ----------------------------------
lua require('lspconfig')['ccls'].setup({})
"  pyright
"  ----------------------------------
lua require('lspconfig')['pyright'].setup({})
"  jsonls
"  ----------------------------------
lua require('lspconfig')['jsonls'].setup({})
"  bashls
"  ----------------------------------
lua require('lspconfig')['bashls'].setup({})

"
" Configure Rust LSP.
"
" https://github.com/simrat39/rust-tools.nvim#configuration
"
lua require'lspconfig'.rust_analyzer.setup({})

" Configure Golang Environment.
"
fun! GoFumpt()
  :silent !gofumpt -w %
  :edit
endfun
autocmd FileType go map <buffer> <leader>p :call append(".", "fmt.Printf(\"%+v\\n\", )")<CR> <bar> :norm $a<CR><esc>j==$i
autocmd FileType go map <buffer> <leader>e :call append(".", "if err != nil {return err}")<CR> <bar> :w<CR>
autocmd BufWritePost *.go call GoFumpt()
autocmd BufWritePost *.go :cex system('revive '..expand('%:p')) | cwindow
" Order imports on save, like goimports does:
"
lua <<EOF
  function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
EOF
autocmd BufWritePre *.go lua OrgImports(1000)
" Configure LSP code navigation shortcuts
" as found in :help lsp
"
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-t>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gn        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" Replaced LSP implementation with code action plugin...
"
" nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
"
nnoremap <silent> ga        <cmd>CodeActionMenu<CR>
nnoremap <silent> [x        <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]x        <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> ]s        <cmd>lua vim.diagnostic.show()<CR>
" Replaced LSP implementation with trouble plugin...
"
" nnoremap <silent> <space>q  <cmd>lua vim.diagnostic.setloclist()<CR>
"
nnoremap <silent> <space>q  <cmd>Trouble<CR>

"lua require'nvim-tree'.setup {}

