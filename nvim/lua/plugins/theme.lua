-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- }

return {
  "nkxxll/ghostty-default-style-dark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("ghostty-default-style-dark").setup({})
    vim.cmd.colorscheme("ghostty-default-style-dark")
  end
}
