-- Notes: obsidian.nvim (community-maintained fork; the original is archived)
-- + in-buffer markdown rendering (replaces glow)
return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        ft = "markdown",
        cmd = "Obsidian",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>nn", "<cmd>Obsidian new<cr>",          desc = "New note" },
            { "<leader>ns", "<cmd>Obsidian search<cr>",       desc = "Search notes" },
            { "<leader>nq", "<cmd>Obsidian quick_switch<cr>", desc = "Switch note" },
            { "<leader>nt", "<cmd>Obsidian today<cr>",        desc = "Today's note" },
            { "<leader>nb", "<cmd>Obsidian backlinks<cr>",    desc = "Backlinks" },
            { "<leader>nw", "<cmd>Obsidian workspace<cr>",    desc = "Switch vault" },
            { "<leader>nl", "<cmd>Obsidian link<cr>",         desc = "Link selection", mode = "v" },
            { "<leader>nc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox", ft = "markdown" },
            { "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox", ft = "markdown" }, -- old bind
            -- the fork also gives note buffers: <CR> smart action (follow link / toggle checkbox),
            -- gf follows links, ]o / [o next/prev link
        },
        opts = {
            legacy_commands = false,
            workspaces = {
                { name = "durham_dnd", path = "~/notes/durham_dnd" },
                { name = "breeze_dnd", path = "~/notes/Breeze" },
            },
            picker = { name = "telescope.nvim" },
            ui = { enable = false },   -- render-markdown handles the looks
        },
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
        keys = {
            { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
        },
        opts = {
            heading = { sign = false, icons = { "󰈸 ", "󰈸 ", "󰈸 ", "󰈸 ", "󰈸 ", "󰈸 " } },
            code = { sign = false, border = "thin" },
            checkbox = { enabled = true },
        },
    },
}
