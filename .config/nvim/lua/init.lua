local nvim_lsp = require('lspconfig')
local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      },
    },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
          },
        cargo = {
          allFeatures = true
          },
        --checkOnSave = {
        --  -- default: `cargo check`
        --  --command = "clippy"
        --  },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
        },
      }
    },
}
require('rust-tools').setup(opts)

--  Configure Golang LSP.
-- 
--  https://github.com/golang/tools/blob/master/gopls/doc/settings.md
--  https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
--  https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
--  https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
--  https://www.getman.io/posts/programming-go-in-neovim/
-- 
require('lspconfig').gopls.setup{
	cmd = {'gopls'},
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
	on_attach = on_attach,
}

 -- Setup Completion
 -- https://github.com/hrsh7th/nvim-cmp#recommended-configuration

-- local cmp = require('cmp')
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--     { name = 'nvim_lsp_signature_help' },
--   },
-- })

 -- Setup Treesitter and friends

 -- NOTE: originally used `ensure_installed = "all"` but an experimental PHP
 -- parser was causing NPM lockfile errors.
require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html", "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml", "zig" },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
require('hlargs').setup()
