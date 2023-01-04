-- nvim completion setup
-- luasnip
  local luasnip = require("luasnip")
  luasnip.config.set_config {
	  history = true,
	  updateevents = "TextChanged,TextChangedI",
	  enable_autosnippets = true,
  }
  vim.keymap.set("i", "<C-s>", function()
	  if luasnip.choice_active() then
		  luasnip.change_choice(1)
	  end 
  end)
-- Setup nvim-cmp.
  local cmp = require'cmp'
-- local func for tab completion
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

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
      --["<Tab>"] = cmp.mapping(function(fallback)
      --if cmp.visible() then
        --cmp.select_next_item()
      --elseif has_words_before() then
        --cmp.complete()
      --else
        --fallback()
      --end
    --end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
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


  local ls = require "luasnip"

  vim.keymap.set({"i", "s" }, "`", function(fallback)
	  if ls.expand_or_jumpable() then
		  ls.expand_or_jump()
	  end
  end, {silent = true})

  -- snippet creation
  local s = ls.s

  -- fmt formatting
  local fmt = require("luasnip.extras.fmt").fmt

  -- aka $1
  local i = luasnip.insert_node

  -- repeat
  local rep = require("luasnip.extras").rep

  -- snippets
  ls.add_snippets ("lua", {
	  -- lua specific snippets
	  	s(
		"req",
		fmt("local {} = require('{}')", {
			i(1, "default"),
			rep(1),
		})
	),
  })

  ls.add_snippets("go", {
	  s(
		  "err_w_ret",
		  fmt("if err != nil {{\n\treturn err\n}}", {
		  })
	  ),
	  s(
		  "err_w_exit",
		  fmt("if err != nil {{\n\tfmt.Println(err)\n\tos.Exit(-1)\n}}", {
		  })
	  ),
  })
