-- lsp/mason

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.config('harper_ls', {
  settings = {
    ['harper-ls'] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
})

vim.lsp.config('emmet_language_server', {
  filetypes = {
    'css',
    'eruby',
    'html',
    'javascript',
    'javascriptreact',
    'less',
    'sass',
    'scss',
    'typescriptreact',
    'rust', -- for leptos
  },
})

local lsp_servers = {
  'basedpyright',
  'bashls',
  'clangd',
  'cssls',
  'emmet_language_server',
  'eslint',
  'harper_ls',
  'html',
  'jdtls',
  'jsonls',
  'lua_ls',
  'nil_ls',
  -- 'rust_analyzer', -- let rustacean set up rust_analyzer
  'sqls',
  'texlab',
  'ts_ls',
}

vim.lsp.enable(lsp_servers)
