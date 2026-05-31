return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  config = function()
    -- Install parsers explicitly (replaces ensure_installed)
    require("nvim-treesitter").install({
      "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"
    })

    -- Enable highlighting manually via native Neovim API
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
          return
        end
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
