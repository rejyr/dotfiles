local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})

-- lightbulb time
vim.o.updatetime = 100

vim.opt.timeoutlen = 500

-- set termgui colors
vim.opt.termguicolors = true

-- Save undo history
vim.o.undofile = true

-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- 4-wide space tabs
vim.o.shiftwidth = 4
vim.o.softtabstop = 8
vim.o.tabstop = 8
vim.o.expandtab = true
vim.o.smarttab = true

-- word wrap
vim.o.linebreak = true

-- map leader key to space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = 'yes'

-- add typst ft
vim.filetype.add { extension = { typ = 'typst' } }

-- set border type
vim.g.border = 'single'
vim.o.winborder = vim.g.border

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    active = true,
  },
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = vim.g.border,
    source = 'always',
    header = '',
    prefix = '',
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        return string.format('%s [%s]', d.message, code):gsub('1. ', '')
      end
      return d.message
    end,
  },
}
