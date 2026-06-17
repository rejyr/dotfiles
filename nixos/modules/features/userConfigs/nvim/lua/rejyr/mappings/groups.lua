local groups = {
  {
    keys = '',
    desc = '',
    mappings = {
      { 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Lsp Hover' } },
      { '<leader>,', '<cmd>FzfLua buffers<cr>', { desc = 'Switch Buffer' } },
      { '<leader>.', '<cmd>lua require("mini.files").open()<cr>', { desc = 'Browse Files' } },
      { '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Search' } },
      { '<leader>:', '<cmd>FzfLua command_history<cr>', { desc = 'Command History' } },
      { '<leader>`', '<cmd>:e #<cr>', { desc = 'Switch to Other Buffer' } },
      { '<leader>u', '<cmd>Undotree<cr>', { desc = 'Undo Tree' } },
      { '<leader>y', '<cmd>YankyRingHistory<cr>', { desc = 'Open Yank History' } },
      { '<leader>Q', ':q<cr>', { desc = ':q' } },
      { '<leader>W', ':wq<cr>', { desc = ':wq' } },
    },
  },
  {
    keys = 'g',
    desc = '+lsp',
    mappings = {
      { 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Type Definition' } },
      { 'gp', '<cmd>lua vim.diagnostic.jump({count=-1})<cr>', { desc = 'Goto Previous Diagnostic' } },
      { 'gn', '<cmd>lua vim.diagnostic.jump({count=1})<cr>', { desc = 'Goto Next Diagnostic' } },
      { 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' } },
      { 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Definition' } },
      { 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Implementation' } },
      { 'grr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'References' } },
      { 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' } },
    },
  },
  {
    keys = '<leader>b',
    desc = '+buffer',
    mappings = {
      { '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer & Window' } },
      { '<leader>bb', '<cmd>FzfLua buffers<cr>', { desc = 'Select Buffer' } },
      { '<leader>bs', '<cmd>:e #<cr>', { desc = 'Switch to Other Buffer' } },
    },
  },
  {
    keys = '<leader>d',
    desc = '+diagnostic',
    mappings = {
      {
        '<leader>dt',
        function()
          local new_value = not vim.diagnostic.config().virtual_lines
          vim.diagnostic.config { virtual_lines = new_value }
        end,
        { desc = 'Toggle Virtual Diagnostic Lines' },
      },
    },
  },
  {
    keys = '<leader>f',
    desc = '+file/format',
    mappings = {
      { '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find File' } },
      { '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' } },
    },
  },
  {
    keys = '<leader>fm',
    desc = '+format',
    mappings = {
      { '<leader>fmt', '<cmd>lua require("conform").format()<cr>', { desc = 'Format' } },
      { '<leader>fml', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Format with LSP' } },
    },
  },
  {
    keys = '<leader>g',
    desc = '+git',
    mappings = {
      { '<leader>gb', '<cmd>FzfLua git_branches<cr>', { desc = 'branches' } },
      { '<leader>gc', '<cmd>FzfLua git_commits<cr>', { desc = 'log' } },
      { '<leader>gg', '<cmd>Git<cr>', { desc = 'Fugitive' } },
      { '<leader>gp', '<cmd>Git push<cr>', { desc = 'Fugitive Git Push' } },
    },
  },
  {
    keys = '<leader>h',
    desc = '+help',
    mappings = {
      { '<leader>hc', '<cmd>FzfLua commands<cr>', { desc = 'Commands' } },
      { '<leader>hh', '<cmd>FzfLua helptags<cr>', { desc = 'Help Pages' } },
      { '<leader>hk', '<cmd>FzfLua keymaps<cr>', { desc = 'Key Maps' } },
      { '<leader>hm', '<cmd>FzfLua manpages<cr>', { desc = 'Man Pages' } },
      { '<leader>hs', '<cmd>FzfLua highlights<cr>', { desc = 'Search Highlight Groups' } },
    },
  },
  {
    keys = '<leader>q',
    desc = '+quit/quickfix',
    mappings = {
      { '<leader>q!', '<cmd>:qa!<cr>', { desc = ':qa!' } },
      { '<leader>qq', '<cmd>qa<cr>', { desc = ':qa' } },
      { '<leader>qs', '<cmd>wqa<cr>', { desc = ':wqa' } },
      { '<leader>qf', '<cmd>cclose<cr>', { desc = 'Close Quickfix List' } },
    },
  },
  {
    keys = '<leader>s',
    desc = '+search/outline',
    mappings = {
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep' } },
      { '<leader>sh', '<cmd>FzfLua command_history<cr>', { desc = 'Command History' } },
      { '<leader>sm', '<cmd>FzfLua marks<cr>', { desc = 'Jump to Mark' } },
      { '<leader>sw', '<cmd>FzfLua diagnostics_workspace<cr>', { desc = 'Diagnostics' } },
      { '<leader>so', '<cmd>Navbuddy<cr>', { desc = 'Outline' } },
    },
  },
  {
    keys = '<leader>w',
    desc = '+windows',
    mappings = {
      { '<leader>w-', '<C-W>s', { desc = 'split-window-below' } },
      { '<leader>w2', '<C-W>v', { desc = 'layout-double-columns' } },
      { '<leader>w=', '<C-W>=', { desc = 'balance-window' } },
      { '<leader>wH', '<C-W>5<', { desc = 'expand-window-left' } },
      { '<leader>wJ', ':resize +5', { desc = 'expand-window-below' } },
      { '<leader>wK', ':resize -5', { desc = 'expand-window-up' } },
      { '<leader>wL', '<C-W>5>', { desc = 'expand-window-right' } },
      { '<leader>wd', '<C-W>c', { desc = 'delete-window' } },
      { '<leader>wh', '<C-W>h', { desc = 'window-left' } },
      { '<leader>wj', '<C-W>j', { desc = 'window-below' } },
      { '<leader>wk', '<C-W>k', { desc = 'window-up' } },
      { '<leader>wl', '<C-W>l', { desc = 'window-right' } },
      { '<leader>ws', '<C-W>s', { desc = 'split-window-below' } },
      { '<leader>wv', '<C-W>v', { desc = 'split-window-right' } },
      { '<leader>ww', '<C-W>p', { desc = 'other-window' } },
      { '<leader>w|', '<C-W>v', { desc = 'split-window-right' } },
    },
  },
}

return groups
