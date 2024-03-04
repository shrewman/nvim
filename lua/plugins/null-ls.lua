return {
  { 'MunifTanjim/prettier.nvim' },
  { "nvimtools/none-ls-extras.nvim" },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'MunifTanjim/prettier.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'
      local group =
        vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
      local event = 'BufWritePre' -- or "BufWritePost"
      local async = event == 'BufWritePost'

      null_ls.setup {
        on_attach = function(client, bufnr)
          if client.supports_method then
            vim.keymap.set('n', '<leader>f', function()
              vim.lsp.buf.format { async = true }
            end, {})
            -- format on save
            -- vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
            -- vim.api.nvim_create_autocmd(event, {
            --   buffer = bufnr,
            --   group = group,
            --   callback = function()
            --     vim.lsp.buf.format { bufnr = bufnr, async = async }
            --   end,
            --   desc = '[lsp] format on save',
            -- })
          end
        end,
        sources = {
          -- null_ls.builtins.code_actions.eslint_d,
          -- null_ls.builtins.diagnostics.eslint_d,
          -- require('none-ls.diagnostics.eslint_d'),
          null_ls.builtins.diagnostics.mypy.with {
            extra_args = { '--ignore-missing-imports' },
          },
          -- null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
