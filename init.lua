require('plugins')

-- shorten the nvim map function
local map = vim.api.nvim_set_keymap

-- options
local opts = {noremap = true, silent = true}

-- leader key. used to toggle into further commands
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- colorscheme stuff
vim.cmd("set termguicolors")
vim.cmd("colorscheme duskfox") -- synthwave :(
vim.cmd("set number")

local telescope = require("telescope")
map("n", "<leader>ff", "<CMD>lua require'telescope.builtin'.find_files()<CR>", opts)
map("n", "<leader>of", "<CMD>lua require'telescope.builtin'.oldfiles()<CR>", opts)
map("n", "<leader>cs", "<CMD>lua require'telescope.builtin'.colorscheme()<CR>", opts)
map("n", "<leader>M", "<CMD>lua require'telescope.builtin'.keymaps()<CR>", opts)
map("n", "<leader>K", "<CMD>lua require'telescope.builtin'.lsp_definitions({jump_type = 'never'})<CR>", opts)
-- map("n", "<leader>H", ":lua require'telescope.builtin'.commands()<CR>", opts) -- seems kinda not useful




-- nvim completion setup
-- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- tab complete like vs code
      ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })








-- set up lsp
require'lspconfig'.gopls.setup{} --setup gopls

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}





-- debugging
-- mapping
map("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<leader>c", "<CMD>lua require'dap'.continue()<CR>", opts)
map("n", "<leader>s", "<CMD>lua require'dap'.step_into()<CR>", opts)
map("n", "<leader>S", "<CMD>lua require'dap'.step_over()<CR>", opts)
map("n", "<leader>O", "<CMD>lua require'dap'.step_out()<CR>", opts)

require("dap")
require("dapui").setup() -- ui for dap
require'dap-go'.setup() -- go debugger dlv

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {text='ඞ', texthl='', linehl='', numhl=''})


-- toggle term
map("t", "<ESC>", [[<C-\><C-n>]], {noremap = true})

require'toggleterm'.setup{
	open_mapping = [[<leader><leader>]],
	direction = 'float'
}
