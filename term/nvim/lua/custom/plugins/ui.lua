return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = 200,
            notify = false,
            preset = "helix",
            win = { border = "rounded" },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>o", group = "open" },
                { "<leader>u", group = "ui" },
                { "<leader>x", group = "diagnostics" },
                { "<localleader>", group = "local" },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "|" },
                change = { text = "|" },
                delete = { text = "_" },
                topdelete = { text = "~" },
                changedelete = { text = "~" },
                untracked = { text = ":" },
            },
            current_line_blame = false,
            preview_config = {
                border = "rounded",
            },
        },
    },
}
