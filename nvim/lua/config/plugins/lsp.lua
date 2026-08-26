return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
  },
  config = function()
    vim.lsp.config('clangd', {
      cmd = { 'clangd', '--header-insertion=never' }
    })

    local lsps = {
      'lua_ls',
      'clangd',
      'cmake',
      'gopls',
      'ts_ls',
      'pyright',
      'marksman',
      'jsonls',
    }
    vim.lsp.enable(lsps)
  end,
}
