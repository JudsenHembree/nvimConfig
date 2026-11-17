-- UI: statusline, keybinding popup, git signs, icons
local p = {
    night = "#0d0b12", ash = "#1b1621", smoke = "#2a2230", muted = "#8a8195",
    parchment = "#f2e6d8", ember = "#ff5a1f", flame = "#ff9e3d", gold = "#ffc857",
    magenta = "#e58cff", mint = "#8ef0a8", red = "#ff6b81", blue = "#7cc4ff",
}

local function mode(color)
    return {
        a = { fg = p.night, bg = color, gui = "bold" },
        b = { fg = p.parchment, bg = p.smoke },
        c = { fg = p.muted, bg = "NONE" },
    }
end

local dragonfire_lualine = {
    normal   = mode(p.ember),
    insert   = mode(p.magenta),
    visual   = mode(p.gold),
    replace  = mode(p.red),
    command  = mode(p.flame),
    terminal = mode(p.mint),
    inactive = { a = { fg = p.muted, bg = p.ash }, b = { fg = p.muted, bg = p.ash }, c = { fg = p.muted, bg = "NONE" } },
}

return {
    { "echasnovski/mini.icons", lazy = true, opts = {},
      init = function()
          package.preload["nvim-web-devicons"] = function()
              require("mini.icons").mock_nvim_web_devicons()
              return package.loaded["nvim-web-devicons"]
          end
      end },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = dragonfire_lualine,
                globalstatus = true,
                component_separators = "",
                section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
            },
            sections = {
                lualine_a = { { "mode", fmt = function(s) return "󰈸 " .. s end, separator = { left = "\u{e0b6}" } } },
                lualine_b = { "branch", "diff" },
                lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " 󰌾" } }, "diagnostics" },
                lualine_x = { "lsp_status", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { { "location", separator = { right = "\u{e0b4}" } } },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 400,
            spec = {
                { "<leader>f", group = "find" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "debug" },
                { "<leader>h", group = "harpoon" },
                { "<leader>n", group = "notes" },
                { "<leader>g", group = "git" },
                { "<leader>u", group = "toggles" },
            },
        },
        keys = {
            { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" }, change = { text = "▎" }, delete = { text = "_" },
                topdelete = { text = "‾" }, changedelete = { text = "▎" }, untracked = { text = "┆" },
            },
            on_attach = function(buf)
                local gs = require("gitsigns")
                local function map(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc }) end
                map("]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("[h", function() gs.nav_hunk("prev") end, "Previous hunk")
                map("<leader>gs", gs.stage_hunk, "Stage hunk")
                map("<leader>gr", gs.reset_hunk, "Reset hunk")
                map("<leader>gp", gs.preview_hunk, "Preview hunk")
                map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
                map("<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
                map("<leader>gD", gs.diffthis, "Diff file")
            end,
        },
    },
}
