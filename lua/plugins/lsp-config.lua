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
      vim.diagnostic.config {
        virtual_text = false,
        signs = false,
      }

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

      lspconfig.gdscript.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
        capabilities = capabilities,
      }

      lspconfig.tsserver.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false

          ---------------------------------------------------------------
        end,
        capabilities = capabilities,
      }

      lspconfig.eslint.setup({
        --- ...
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
      }

      lspconfig.emmet_language_server.setup {
        capabilities = capabilities,
        init_options = {
          filetypes = {
            'css',
            'eruby',
            'html',
            'javascript',
            'javascriptreact',
            'less',
            'sass',
            'scss',
            'pug',
            'typescript',
            'typescriptreact',
          },
          -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
          -- **Note:** only the options listed in the table are supported.
          init_options = {
            ---@type table<string, string>
            includeLanguages = {},
            --- @type string[]
            excludeLanguages = {},
            --- @type string[]
            extensionsPath = {},
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
            preferences = {},
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = true,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = 'always',
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
            syntaxProfiles = {},
            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
            variables = {},
          },
        },
      }
      ------------------------------------

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
