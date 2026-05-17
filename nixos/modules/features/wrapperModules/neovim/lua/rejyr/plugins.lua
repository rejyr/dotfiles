local minimisc = require 'mini.misc'
local function later(f)
  ---@diagnostic disable-next-line: undefined-global
  minimisc.safely('later', f)
end

vim.cmd 'packadd nvim.undotree'

-- update hooks
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    -- :TSUpdate for treesitter
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- colorscheme
vim.g.everforest_background = 'medium'
vim.g.everforest_ui_contrast = 'high'
vim.g.everforest_transparent_background = 2
vim.cmd 'colorscheme everforest'
vim.cmd 'set background=dark'

-- rust
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        -- all features for leptos
        cargo = {
          features = 'all',
        },
        procMacro = {
          ignored = {
            -- leptos macros
            leptos_macro = {
              -- optional: --
              -- "component",
              'server',
            },
          },
        },
      },
    },
  },
}

-- latex
vim.g.vimtex_view_method = 'zathura'

-- rainbow-delimiters
vim.g.rainbow_delimiters = {
  highlight = {
    'Red',
    'Yellow',
    'Blue',
    'Orange',
    'Green',
  },
}

-- mini plugins
require('mini.files').setup()
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
require('mini.statusline').setup()

later(function()
  require('mini.ai').setup()
  require('mini.bracketed').setup()
  require('mini.comment').setup()
  require('mini.diff').setup()
  require('mini.extra').setup()
  require('mini.jump').setup()
  require('mini.notify').setup()
  require('mini.pairs').setup()
  require('mini.surround').setup()
end)

later(function()
  local function timing(_, total)
    local ms = 100
    return ms / total
  end
  require('mini.animate').setup {
    cursor = {
      timing = timing,
    },
    scroll = {
      timing = timing,
    },
  }
end)
later(function()
  local hipatterns = require 'mini.hipatterns'
  hipatterns.setup {
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end)
later(function()
  require('mini.indentscope').setup {
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
    },
    symbol = '▎',
  }
end)
later(function()
  require('mini.jump2d').setup {
    view = {
      dim = true,
      n_steps_ahead = 1,
    },
    mappings = { start_jumping = '' },
  }
end)
later(function()
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup {
    snippets = {
      gen_loader.from_lang(),
    },
  }
end)
later(function()
  require('mini.trailspace').setup()
  local augroup = vim.api.nvim_create_augroup('RemoveTrailingWhitespace', {})
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    callback = function()
      require('mini.trailspace').trim()
      require('mini.trailspace').trim_last_lines()
    end,
  })
end)

-- completion
require('blink.cmp').setup {
  keymap = { preset = 'super-tab' },
  completion = {
    list = {
      selection = {
        preselect = function(_)
          return not require('blink.cmp').snippet_active { direction = 1 }
        end,
      },
    },
    documentation = { auto_show = true },
    ghost_text = { enabled = true },
  },
  signature = { enabled = true },
  snippets = { preset = 'mini_snippets' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}

-- picker
later(function()
  require('fzf-lua').setup {
    fzf_bin = 'sk',
    winopts = {
      border = vim.g.border,
      preview = {
        border = vim.g.border,
      },
    },
    actions = {
      files = {
        true,
        ['ctrl-q'] = { fn = require('fzf-lua').actions.file_sel_to_qf, prefix = 'select-all' },
      },
    },
  }
end)

-- formatter
later(function()
  require('conform').setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      python = { 'autopep8' },
      toml = { 'taplo' },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  }
end)

-- clipboard
later(function()
  require('yanky').setup()
end)

-- better quickfix
later(function()
  require('quicker').setup()
end)

-- navbuddy/outline
later(function()
  require('nvim-navbuddy').setup {
    window = {
      border = vim.g.border,
      size = '80%',
    },
    lsp = {
      auto_attach = true,
    },
  }
end)
