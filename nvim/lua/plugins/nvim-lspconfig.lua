return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          {
            path = "${3rd}/luv/library",
            words = { "vim%.uv" }
          },
        },
      },
    },
  },
  config = function()
    vim.lsp.enable('lua_ls')

    vim.lsp.enable('gopls')

    vim.filetype.add({
      extension = {
        tpp = "cpp",
      },
    })
    vim.lsp.config('clangd', {
      cmd = {
        'clangd',
        '--header-insertion=never',
      },
    })
    vim.lsp.enable('clangd')

    vim.lsp.enable('ts_ls');

    vim.lsp.enable('pyright');

    vim.lsp.enable('cssls')
    vim.lsp.enable('html')
    vim.lsp.enable('jsonls')
    vim.lsp.enable('marksman')
  end
}
