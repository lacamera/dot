local group = vim.api.nvim_create_augroup("custom_core", { clear = true })

vim.filetype.add({
    extension = {
        frag = "glsl",
        vert = "glsl",
    },
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.hl.on_yank({ timeout = 120 })
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function(event)
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(event.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(event)
        local file = (vim.uv or vim.loop).fs_realpath(event.match) or event.match
        local dir = vim.fn.fnamemodify(file, ":p:h")
        if dir ~= "" then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "gitcommit", "markdown", "text", "typst" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = ""
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "help",
        "lspinfo",
        "man",
        "neo-tree",
        "qf",
        "startuptime",
        "tsplayground",
        "Trouble",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "neo-tree", "Trouble", "help", "qf" },
    callback = function()
        vim.opt_local.winbar = ""
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = group,
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "o", "r" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "csv", "markdown", "typst" },
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "<localleader>p", "<cmd>OmniPreview start<cr>", vim.tbl_extend("force", opts, {
            desc = "Start preview",
        }))
        vim.keymap.set("n", "<localleader>P", "<cmd>OmniPreview stop<cr>", vim.tbl_extend("force", opts, {
            desc = "Stop preview",
        }))
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "typst",
    callback = function(event)
        vim.keymap.set("n", "<localleader>e", "<cmd>ExportPicker<cr>", {
            buffer = event.buf,
            desc = "Export Typst",
            silent = true,
        })
    end,
})
