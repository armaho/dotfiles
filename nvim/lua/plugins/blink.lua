return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-k>'] = false, -- we use this instead of the <Up> in insert mode
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
