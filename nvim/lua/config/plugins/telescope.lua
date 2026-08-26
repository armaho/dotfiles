return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
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

      vim.keymap.set('n', '<leader>fg',
        function()
          local opts = {}
          local search_dir = vim.fn.execute("pwd")
          local dir = vim.fs.basename(search_dir)

          if (dir:find("ros")) then
            opts.glob_pattern = "!{build,install,log}"
          end

          builtin.live_grep(opts)
        end,
        { desc = 'Telescope live grep' }
      )

      vim.keymap.set('n', '<leader>fb', builtin.buffers,
        { desc = 'Telescope buffers' }
      )

      vim.keymap.set("n", "<leader>ff",
        function()
          local find_command = { "rg", "--files", "--hidden", "--no-require-git" }

          local search_dir = vim.fn.execute("pwd")
          local dir = vim.fs.basename(search_dir)

          if (dir:find("ros")) then
            table.insert(find_command, "--glob")
            table.insert(find_command, "!{build,install,log}")
          end

          builtin.find_files({ find_command = find_command })
        end,
        { desc = "Telescope find files" }
      )
    end
  }
}
