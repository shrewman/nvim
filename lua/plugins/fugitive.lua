return {
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set(
        'n',
        '<leader>g',
        '<cmd>Gitsigns preview_hunk_inline<CR>',
        {}
      );
      vim.keymap.set(
        'n',
        '<leader>[',
        '<cmd>Gitsigns prev_hunk<CR>',
        {}
      )
      vim.keymap.set(
        'n',
        '<leader>]',
        '<cmd>Gitsigns next_hunk<CR>',
        {}
      )
      vim.keymap.set(
        'n',
        '<leader>hs',
        '<cmd>Gitsigns stage_hunk<CR>',
        {}
      )
      vim.keymap.set(
        'n',
        '<leader>hu',
        '<cmd>Gitsigns undo_stage_hunk<CR>',
        {}
      )
    end,
  },
}
