return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'jsonls',
        'html',
        'cssls',
        'tsserver',
        'tailwindcss',
        'eslint_d',
        'prettier_d',
        'pyright',
        'black',
        'mypy',
        'ruff',
        'lua_ls',
        'stylua',
      },
      auto_install = true,
    },
    config = function()
      require('mason-lspconfig').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lspconfig = require 'lspconfig'
      vim.diagnostic.config { virtual_text = false }

      --------------------------------------
      lspconfig.html.setup {
        capabilities = capabilities,
      }

      lspconfig.lua_ls.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
        capabilities = capabilities,
      }

      lspconfig.pyright.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
        capabilities = capabilities,
      }

      lspconfig.tsserver.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false

          -- Automatically end a self-closing tag when pressing /
          vim.keymap.set('i', '/', function()
            local ts_utils = require 'nvim-treesitter.ts_utils'

            local node = ts_utils.get_node_at_cursor()
            if not node then
              return '/'
            end

            if node:type() == 'jsx_opening_element' then
              local char_at_cursor = vim.fn.strcharpart(
                vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2),
                0,
                1
              )
              local already_have_space = char_at_cursor == ' '

              return already_have_space and '/>' or ' />'
            end

            return '/'
          end, { expr = true, buffer = true })
          ---------------------------------------------------------------

        end,
        capabilities = capabilities,
      }

      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
      }

      -- lspconfig.emmet_ls.setup {
      --   capabilities = capabilities,
      --   filetypes = {
      --     'css',
      --     'html',
      --     'javascript',
      --     'javascriptreact',
      --     'less',
      --     'scss',
      --     'typescriptreact',
      --   },
      --   init_options = {
      --     html = {
      --       options = {
      --         -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
      --         ['bem.enabled'] = false,
      --       },
      --     },
      --   },
      -- }
      --------------------------------------

      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})

      vim.keymap.set(
        'n',
        '<leader>ca',
        '<cmd>lua vim.lsp.buf.code_action()<cr>',
        {}
      )

      vim.keymap.set('n', '[d', vim.diagnostic.goto_next, {})
      vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, {})
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
    end,
  },
}
