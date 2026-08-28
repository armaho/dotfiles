local function config_debuggers()
  local dap = require "dap"

  dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp


  local mason = require "mason.settings"
  dap.adapters["local-lua"] = {
    type = "executable",
    command = "node",
    args = {
      mason.current.install_root_dir ..
      "/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js"
    },
    enrich_config = function(config, on_config)
      if not config["extensionPath"] then
        local c = vim.deepcopy(config)
        c.extensionPath = mason.current.install_root_dir ..
            "/packages/local-lua-debugger-vscode/extension"
        on_config(c)
      else
        on_config(config)
      end
    end,
  }
  dap.configurations.lua = {
    {
      type = "local-lua",
      name = "Launch file",
      request = "launch",
      cwd = "${workspaceFolder}",
      program = {
        lua = "lua5.5",
        file = "${file}",
      },
      args = {},
    },
  }
end

local function config_nvim()
  local dap = require "dap"

  vim.keymap.set("n", "<leader>dn", "<cmd>DapNew<CR>", {
    desc = "start in debugging mode"
  })
  vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", {
    desc = "toggle breakpoint"
  })

  local debugging_keymaps = {
    { mode = "n", lhs = "<leader>dc", rhs = dap.continue,  desc = "continue" },
    { mode = "n", lhs = "<Up>",       rhs = dap.step_back, desc = "step back" },
    { mode = "n", lhs = "<Down>",     rhs = dap.step_over, desc = "step over" },
    { mode = "n", lhs = "<Right>",    rhs = dap.step_into, desc = "step into" },
    { mode = "n", lhs = "<Left>",     rhs = dap.step_out,  desc = "step out" },
  }

  local function set_debugging_keymaps()
    print("set_debugging_keymaps called")
    for _, km in ipairs(debugging_keymaps) do
      vim.keymap.set(km.mode, km.lhs, km.rhs, {
        desc = km.desc
      })
    end
  end

  local function remove_debugging_keymaps()
    for _, km in ipairs(debugging_keymaps) do
      local success, result = pcall(vim.keymap.del, km.mode, km.lhs)
      if not success and not tostring(result):match("No such mapping") then
        error(result, 0)
      end
    end
  end

  dap.listeners.after.attach.set_keymaps = set_debugging_keymaps
  dap.listeners.after.launch.set_keymaps = set_debugging_keymaps
  dap.listeners.after.event_terminated.remove_keymaps = remove_debugging_keymaps
  dap.listeners.after.event_exited.remove_keymaps = remove_debugging_keymaps
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mason-org/mason.nvim",
  },
  config = function()
    config_debuggers()
    config_nvim()
  end
}
