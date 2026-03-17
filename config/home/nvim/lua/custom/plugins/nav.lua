return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
            { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        config = function()
            local actions = require("telescope.actions")
            local themes = require("telescope.themes")
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = "  ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    layout_strategy = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "top",
                        width = 0.92,
                        height = 0.84,
                    },
                    path_display = { "truncate" },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<Esc>"] = actions.close,
                        },
                    },
                },
                pickers = {
                    buffers = themes.get_dropdown({
                        previewer = false,
                        sort_lastused = true,
                    }),
                    diagnostics = themes.get_ivy({}),
                    find_files = {
                        hidden = true,
                    },
                },
                extensions = {
                    ["ui-select"] = themes.get_dropdown({}),
                },
            })

            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true, reveal = true })
                end,
                desc = "Explorer",
            },
            {
                "<leader>E",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer explorer",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                opts = {
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                },
            },
        },
        opts = {
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            sources = { "filesystem", "buffers", "git_status" },
            default_component_configs = {
                indent = {
                    padding = 0,
                    with_markers = false,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                },
                git_status = {
                    symbols = {
                        added = "",
                        modified = "",
                        deleted = "✖",
                        renamed = "󰁕",
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "left",
                width = 32,
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<cr>"] = "open",
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["s"] = "open_vsplit",
                    ["S"] = "open_split",
                    ["w"] = "open_with_window_picker",
                    ["H"] = "toggle_hidden",
                    ["/"] = "fuzzy_finder",
                    ["q"] = "close_window",
                },
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    never_show = { ".DS_Store" },
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                },
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
        },
    },
}
