return {
  "ErickKramer/nvim-ros2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  opts = {
    autocmds = true,
    treesitter = true,
  },
  keys = {
    { "<leader>li", function() require("nvim-ros2").pickers.interfaces() end, desc = "[ROS 2]: List interfaces" },
    { "<leader>ln", function() require("nvim-ros2").pickers.nodes() end, desc = "[ROS 2]: List nodes" },
    { "<leader>la", function() require("nvim-ros2").pickers.actions() end, desc = "[ROS 2]: List actions" },
    { "<leader>lt", function() require("nvim-ros2").pickers.topics_info() end, desc = "[ROS 2]: List topics with info" },
    { "<leader>le", function() require("nvim-ros2").pickers.topics_echo() end, desc = "[ROS 2]: List topics with echo" },
    { "<leader>ls", function() require("nvim-ros2").pickers.services() end, desc = "[ROS 2]: List services" },
  },
  config = function()
    vim.filetype.add({
      extension = {
        msg = "ros2",
        srv = "ros2",
        action = "ros2",
      },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").ros2 = {
          install_info = {
            path = "~/.local/share/nvim/lazy/nvim-ros2/treesitter-ros2",
            generate = false,
          },
          filetype = "ros2",
        }
      end,
    })
  end,
}
