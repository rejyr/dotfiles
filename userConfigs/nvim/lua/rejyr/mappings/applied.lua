-- keymap util
local map = vim.keymap.set

-- write on escape
map('n', '<Esc>', ':w<cr>')

-- set proper paste keybind
map(
    'i',
    '<C-r>',
    '<C-r><C-o>',
    { desc = 'Insert contents of named register. Inserts text literally, not as if you typed it.' }
)

-- Move to window using the <ctrl> movement keys
map('n', '<S-Left>', '<C-w>h')
map('n', '<S-Down>', '<C-w>j')
map('n', '<S-Up>', '<C-w>k')
map('n', '<s-Right>', '<C-w>l')

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>')
map('n', '<C-Down>', '<cmd>resize -2<cr>')
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>')
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ 'n', 'x', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true })
map({ 'n', 'x', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true })

-- ZZ extensions
map('n', 'ZA', '<cmd>wqa<cr>')

-- save in insert mode
map({ 'n', 'i' }, '<C-s>', '<cmd>:w<cr><esc>')
map('n', '<C-c>', '<cmd>normal ciw<cr>a')

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- move through quickfix list
map('n', '<C-j>', '<cmd>cnext<cr>')
map('n', '<C-k>', '<cmd>cprev<cr>')

-- mini.jump2d mappings
map({ 'n', 'x', 'o' }, '<CR>', '<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>')

local function add_mappings(groups_table)
    for _, group in pairs(groups_table) do
        for _, mapping in pairs(group['mappings']) do
            ---@diagnostic disable-next-line: deprecated
            map('n', unpack(mapping))
        end
    end
end

local groups = require 'rejyr.mappings.groups'
add_mappings(groups)
