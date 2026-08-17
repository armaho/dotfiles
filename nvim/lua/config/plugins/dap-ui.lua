return {
  "rcarriga/nvim-dap-ui",
  enable = false,
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dapui.setup()

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open

    vim.keymap.set("n", "<leader>du", dapui.close, {
      desc = "close dap-ui"
    })
  end
}
