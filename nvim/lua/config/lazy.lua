local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  print("Cannot find lazy. Attempting to fetch...")

  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  local out = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }):wait()
  if out.code ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n" },
      { out.stderr },
      { "\nPress any key to exit..." },
    }, true, { err = true })

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      import = "config.plugins"
    },
  },
})
