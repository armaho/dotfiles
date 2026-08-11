return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          fzf = {}
        }
      }
      telescope.load_extension('fzf')
      local builtin = require('telescope.builtin')

      vim.keymap.set("n", "<leader>fh", builtin.help_tags,
        { desc = "Telescope help tags" }
      )

      vim.keymap.set('n', '<leader>fg', builtin.live_grep,
        { desc = 'Telescope live grep' }
      )

      vim.keymap.set('n', '<leader>fb', builtin.buffers,
        { desc = 'Telescope buffers' }
      )

      vim.keymap.set("n", "<leader>ff",
        function()
          builtin.find_files(
            {
              find_command = { "rg", "--files", "--hidden", "--no-require-git" }
            })
        end,
        { desc = "Telescope find files" }
      )
    end
  }
}
