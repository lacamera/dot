return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local uv = vim.uv or vim.loop
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "go",
                    "glsl",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "ruby",
                    "rust",
                    "svelte",
                    "toml",
                    "tsx",
                    "typescript",
                    "typst",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 200 * 1024
                        local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        return ok and stats and stats.size > max_filesize
                    end,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = "<S-CR>",
                        node_decremental = "<BS>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        opts = function()
            local ok, integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
            return ok and { pre_hook = integration.create_pre_hook() } or {}
        end,
    },
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = { n_lines = 500 },
    },
    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "sylvanfranklin/pear",
        keys = {
            {
                "<leader>j",
                function()
                    require("pear").jump_pair()
                end,
                desc = "Jump paired file",
            },
        },
    },
}
