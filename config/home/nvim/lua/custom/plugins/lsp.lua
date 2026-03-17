return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "bash-language-server",
                "gofumpt",
                "goimports",
                "gopls",
                "lua-language-server",
                "marksman",
                "prettierd",
                "ruff",
                "ruby-lsp",
                "rust-analyzer",
                "shfmt",
                "stylua",
                "svelte-language-server",
                "tinymist",
                "typstyle",
                "yaml-language-server",
            },
            run_on_start = true,
        },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = { preset = "default" },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                menu = {
                    auto_show = true,
                    border = "rounded",
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = "rounded",
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                },
            },
            cmdline = {
                keymap = { preset = "cmdline" },
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },
        opts_extend = { "sources.default" },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    timeout_ms = 1000,
                    lsp_format = "fallback",
                }
            end,
            formatters_by_ft = {
                bash = { "shfmt" },
                css = { "prettierd", "prettier" },
                go = { "goimports", "gofumpt" },
                html = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                lua = { "stylua" },
                markdown = { "prettierd", "prettier" },
                python = { "ruff_format" },
                ruby = { "rubocop" },
                rust = { "rustfmt" },
                sh = { "shfmt" },
                svelte = { "prettierd", "prettier" },
                toml = { "taplo" },
                typescript = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                typst = { "typstyle" },
                yaml = { "prettierd", "prettier" },
                zsh = { "shfmt" },
            },
        },
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
            { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
        },
        opts = {
            focus = true,
            warn_no_results = false,
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "folke/lazydev.nvim",
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities({
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            })

            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                update_in_insert = false,
                virtual_text = false,
                float = {
                    border = "rounded",
                    source = "if_many",
                },
                jump = {
                    float = true,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                    },
                },
            })

            local servers = {
                bashls = {},
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            hint = {
                                enable = true,
                            },
                            runtime = {
                                version = "LuaJIT",
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                        },
                    },
                },
                marksman = {},
                ruby_lsp = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
                svelte = {},
                tinymist = {
                    settings = {
                        formatterMode = "typstyle",
                        exportPdf = "never",
                    },
                },
                yamlls = {},
            }

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            for server, config in pairs(servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end

            local attach_group = vim.api.nvim_create_augroup("custom_lsp_attach", { clear = true })

            vim.api.nvim_create_autocmd("BufWritePost", {
                group = vim.api.nvim_create_augroup("custom_svelte_watch", { clear = true }),
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                    for _, client in ipairs(vim.lsp.get_clients({ name = "svelte" })) do
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = attach_group,
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if not client then
                        return
                    end

                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc, silent = true })
                    end

                    local telescope = function(method, opts)
                        return function()
                            require("telescope.builtin")[method](opts or {})
                        end
                    end

                    map("n", "gd", telescope("lsp_definitions"), "Goto definition")
                    map("n", "gr", telescope("lsp_references"), "Goto references")
                    map("n", "gi", telescope("lsp_implementations"), "Goto implementation")
                    map("n", "gt", telescope("lsp_type_definitions"), "Goto type definition")
                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
                    map("n", "<leader>cf", function()
                        require("conform").format({
                            async = false,
                            lsp_format = "fallback",
                        })
                    end, "Format buffer")
                    map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
                    map("n", "<leader>cD", telescope("diagnostics", { bufnr = 0 }), "Buffer diagnostics")
                    map("n", "<leader>cs", telescope("lsp_document_symbols"), "Document symbols")
                    map("n", "<leader>cS", telescope("lsp_workspace_symbols"), "Workspace symbols")
                    map("n", "[d", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, "Previous diagnostic")
                    map("n", "]d", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, "Next diagnostic")
                    map("n", "<leader>ci", function()
                        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
                    end, "Toggle inlay hints")

                    if client:supports_method("textDocument/documentHighlight") then
                        local highlight_group = vim.api.nvim_create_augroup("custom_lsp_highlight_" .. event.buf, {
                            clear = true,
                        })

                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            group = highlight_group,
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
                            group = highlight_group,
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    if client:supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                    end
                end,
            })
        end,
    },
}
