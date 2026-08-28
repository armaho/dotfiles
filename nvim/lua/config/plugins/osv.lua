return {
  "jbyuki/one-small-step-for-vimkind",
  config = function()
    local osv = require "osv"
    vim.keymap.set('n', '<leader>dl', function()
      osv.launch({ port = 8086 })
    end)
  end,
}
