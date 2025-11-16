vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 10

vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.o.cursorline = true

vim.o.confirm = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.shell = os.getenv("SHELL")

vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-e>', ':Ex<CR>', { desc = 'Open netrw' })

vim.keymap.set('n', '<leader>o', 'o<Esc>O', { desc = 'Double new line' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yank' })

vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bf', ':bfirst<CR>', { desc = 'First buffer' })
vim.keymap.set('n', '<leader>bl', ':blast<CR>', { desc = 'Last buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer' })

vim.keymap.set('n', '<leader>tt', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tw', '<C-w>T', { desc = 'Break out window into new tab' })
vim.keymap.set('n', '<leader>tn', 'gt', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', 'gT', { desc = 'Next tab' })

vim.keymap.set('v', '<C-j>', ':m\'>+1<CR>gv', { desc = 'Move selection down' })
vim.keymap.set('v', '<C-k>', ':m\'<-2<CR>gv', { desc = 'Move selection up' })

vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Left arrow' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Up arrow' })
vim.keymap.set('s', '<C-k>', '<Up>', { desc = 'Up arrow' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Down arrow' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Right arrow' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

