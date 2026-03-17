return {
    {
        "sylvanfranklin/omni-preview.nvim",
        cmd = "OmniPreview",
        keys = {
            { "<leader>op", "<cmd>OmniPreview start<cr>", desc = "Start preview" },
            { "<leader>oP", "<cmd>OmniPreview stop<cr>", desc = "Stop preview" },
        },
        dependencies = {
            {
                "toppair/peek.nvim",
                build = function(plugin)
                    if vim.fn.executable("deno") == 1 then
                        vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = plugin.dir }):wait()
                    end
                end,
            },
            {
                "chomosuke/typst-preview.nvim",
                ft = "typst",
                opts = {},
            },
        },
        config = function()
            require("omni-preview").setup()
            require("peek").setup({ app = "browser" })
        end,
    },
    {
        "hat0uma/csvview.nvim",
        ft = "csv",
        opts = {
            view = {
                display_mode = "border",
            },
        },
    },
}
