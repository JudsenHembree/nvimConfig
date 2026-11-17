-- Telescope (fuzzy finding) + Harpoon (file marks)
local function tb(fn, opts)
    return function() require("telescope.builtin")[fn](opts) end
end

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", tb("find_files"),  desc = "Files" },
            { "<leader>fg", tb("live_grep"),   desc = "Grep" },
            { "<leader>fw", tb("grep_string"), desc = "Grep word under cursor" },
            { "<leader>fo", tb("oldfiles"),    desc = "Recent files" },
            { "<leader>fb", tb("buffers"),     desc = "Buffers" },
            { "<leader>fh", tb("help_tags"),   desc = "Help" },
            { "<leader>fk", tb("keymaps"),     desc = "Keymaps" },
            { "<leader>fd", tb("diagnostics"), desc = "Diagnostics" },
            { "<leader>fc", tb("colorscheme", { enable_preview = true }), desc = "Colorschemes" },
            { "<leader>fr", tb("resume"),      desc = "Resume last search" },
            { "<leader>f/", tb("current_buffer_fuzzy_find"), desc = "Search in buffer" },
            -- old binds, kept
            { "<leader>rg", tb("live_grep"),   desc = "Grep" },
            { "<leader>of", tb("oldfiles"),    desc = "Recent files" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    prompt_prefix = "󰈸 ",
                    selection_caret = "  ",
                    sorting_strategy = "ascending",
                    layout_config = { prompt_position = "top" },
                    file_ignore_patterns = { "%.git/", "node_modules/", "build/", "target/" },
                },
                pickers = { find_files = { hidden = true } },
            })
            pcall(telescope.load_extension, "fzf")
        end,
    },

    {
        -- harpoon v1 API (same as the old config)
        "ThePrimeagen/harpoon",
        branch = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
            { "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
            { "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
            { "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
            { "<leader>h3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon 3" },
            { "<leader>h4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon 4" },
            { "<leader>hn", function() require("harpoon.ui").nav_next() end, desc = "Harpoon next" },
            { "<leader>hp", function() require("harpoon.ui").nav_prev() end, desc = "Harpoon previous" },
            -- old binds, kept
            { "<leader>hh", function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
            { "<leader>H",  function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
        },
        opts = {},
    },
}
