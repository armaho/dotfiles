return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require "nvim-treesitter"
    local langs = {
      "c",
      "cpp",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline"
    }

    ts.install(langs)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
