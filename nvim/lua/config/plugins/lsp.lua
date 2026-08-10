return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
  },
  config = function()
    vim.lsp.enable('lua_ls')
  end,
}
