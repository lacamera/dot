local M = {}

local palettes = {
    dark = {
        float_bg = "#1d2021",
        border = "#3c3836",
        status_fg = "#ebdbb2",
        status_nc = "#7c6f64",
        cursor_nr = "#fabd2f",
        winbar = "#d5c4a1",
        winbar_nc = "#7c6f64",
    },
    light = {
        float_bg = "#f2e5bc",
        border = "#d5c4a1",
        status_fg = "#504945",
        status_nc = "#bdae93",
        cursor_nr = "#b57614",
        winbar = "#665c54",
        winbar_nc = "#bdae93",
    },
}

local current_mode

local function macos_appearance()
    local override = vim.env.MACOS_APPEARANCE
    if override == "Dark" or override == "dark" then
        return "dark"
    end
    if override == "Light" or override == "light" then
        return "light"
    end

    if vim.fn.has("mac") == 0 and vim.fn.has("macunix") == 0 then
        return vim.o.background == "light" and "light" or "dark"
    end

    local result = vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }):wait()
    if result.code == 0 and result.stdout and result.stdout:find("Dark") then
        return "dark"
    end

    return "light"
end

local function variant_for(mode)
    if mode == "dark" then
        return {
            background = "dark",
            contrast = "hard",
            palette = palettes.dark,
        }
    end

    return {
        background = "light",
        contrast = "soft",
        palette = palettes.light,
    }
end

function M.apply()
    local mode = macos_appearance()
    if current_mode == mode and vim.g.colors_name == "gruvbox" then
        return
    end

    local variant = variant_for(mode)

    vim.opt.background = variant.background
    require("gruvbox").setup({
        contrast = variant.contrast,
        transparent_mode = false,
    })
    vim.cmd.colorscheme("gruvbox")

    local p = variant.palette
    local set = vim.api.nvim_set_hl
    set(0, "NormalFloat", { bg = p.float_bg })
    set(0, "FloatBorder", { bg = p.float_bg, fg = p.border })
    set(0, "WinSeparator", { bg = "none", fg = p.border })
    set(0, "StatusLine", { bg = p.float_bg, fg = p.status_fg })
    set(0, "StatusLineNC", { bg = p.float_bg, fg = p.status_nc })
    set(0, "CursorLineNr", { fg = p.cursor_nr, bg = "none", bold = true })
    set(0, "SignColumn", { bg = "none" })
    set(0, "FoldColumn", { bg = "none" })
    set(0, "LineNr", { bg = "none" })
    set(0, "WinBar", { bg = "none", fg = p.winbar })
    set(0, "WinBarNC", { bg = "none", fg = p.winbar_nc })
    set(0, "NeoTreeNormal", { bg = p.float_bg })
    set(0, "NeoTreeNormalNC", { bg = p.float_bg })
    set(0, "NeoTreeFloatBorder", { bg = p.float_bg, fg = p.border })

    current_mode = mode
    vim.g.macos_appearance = mode
end

function M.setup()
    if vim.g.appearance_sync_loaded then
        M.apply()
        return
    end

    vim.g.appearance_sync_loaded = true

    local group = vim.api.nvim_create_augroup("custom_appearance", { clear = true })

    vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
        group = group,
        callback = function()
            pcall(M.apply)
        end,
    })

    vim.api.nvim_create_user_command("ThemeSync", function()
        M.apply()
    end, { desc = "Sync theme to macOS appearance" })

    M.apply()
end

return M
