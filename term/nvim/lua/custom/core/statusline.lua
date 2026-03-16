local M = {}

local disabled_filetypes = {
    ["checkhealth"] = true,
    ["help"] = true,
    ["lazy"] = true,
    ["mason"] = true,
    ["neo-tree"] = true,
    ["qf"] = true,
    ["Trouble"] = true,
}

local mode_names = {
    n = "RW",
    no = "RO",
    v = "VIS",
    V = "VIS",
    ["\22"] = "V-B",
    s = "SEL",
    S = "S-L",
    i = "INS",
    ic = "INS",
    R = "REP",
    Rv = "V-R",
    c = "EX",
    cv = "EX",
    ce = "EX",
    r = "...",
    rm = "...",
    ["r?"] = "?",
    ["!"] = "!",
    t = "TERM",
}

local mode_highlights = {
    n = "StatusNormal",
    no = "StatusNormal",
    v = "StatusVisual",
    V = "StatusVisual",
    ["\22"] = "StatusVisual",
    s = "StatusVisual",
    S = "StatusVisual",
    i = "StatusInsert",
    ic = "StatusInsert",
    R = "StatusReplace",
    Rv = "StatusReplace",
    c = "StatusCommand",
    cv = "StatusCommand",
    ce = "StatusCommand",
    t = "StatusTerminal",
}

local function is_disabled()
    return disabled_filetypes[vim.bo.filetype] or vim.bo.buftype == "prompt"
end

local function get_icon(name)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok then
        return "", nil
    end

    local ext = vim.fn.fnamemodify(name, ":e")
    return icons.get_icon(name, ext, { default = true })
end

local function current_mode()
    local mode = vim.api.nvim_get_mode().mode
    local label = mode_names[mode] or mode
    local highlight = mode_highlights[mode] or "StatusLine"
    return string.format("%%#%s# %s %%#StatusLine#", highlight, label)
end

local function file_name()
    local name = vim.fn.expand("%:t")
    if name == "" then
        return " %#Comment#nyoom-core %#StatusLine#"
    end

    local icon, icon_hl = get_icon(name)
    local modified = vim.bo.modified and " [+]" or ""
    local readonly = vim.bo.readonly and " " or ""
    local icon_part = ""

    if icon ~= "" and icon_hl then
        icon_part = string.format("%%#%s#%s %%#StatusLine#", icon_hl, icon)
    end

    return string.format(" %s%s%s%s ", icon_part, name, modified, readonly)
end

local function git_branch()
    local gitsigns = vim.b.gitsigns_status_dict
    if not gitsigns or not gitsigns.head or gitsigns.head == "" then
        return ""
    end

    return string.format("%%#Comment#  %s %%#StatusLine#", gitsigns.head)
end

local function diagnostics()
    local counts = {
        error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
        warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
        info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
    }

    local parts = {}
    if counts.error > 0 then
        parts[#parts + 1] = string.format("%%#DiagnosticError# %d", counts.error)
    end
    if counts.warn > 0 then
        parts[#parts + 1] = string.format("%%#DiagnosticWarn# %d", counts.warn)
    end
    if counts.info > 0 then
        parts[#parts + 1] = string.format("%%#DiagnosticInfo# %d", counts.info)
    end

    if #parts == 0 then
        return ""
    end

    return table.concat(parts, " ") .. "%#StatusLine# "
end

local function location()
    return "%#Comment# %l:%c %P %#StatusLine#"
end

local function search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end

    local ok, count = pcall(vim.fn.searchcount, { recompute = true, maxcount = 999 })
    if not ok or count.current == nil or count.total == 0 then
        return ""
    end

    return string.format("%%#Comment# %d/%d %#StatusLine#", count.current, count.total)
end

function M.statusline()
    if is_disabled() then
        return "%#StatusLine# %f %= %l:%c "
    end

    return table.concat({
        current_mode(),
        file_name(),
        git_branch(),
        "%=",
        diagnostics(),
        search_count(),
        string.format(" %%#Comment#%s %%#StatusLine#", vim.bo.filetype ~= "" and vim.bo.filetype or "text"),
        location(),
    })
end

function M.winbar()
    if is_disabled() then
        return ""
    end

    local name = vim.fn.expand("%:~:.")
    if name == "" then
        return ""
    end

    local tail = vim.fn.fnamemodify(name, ":t")
    local icon, icon_hl = get_icon(tail)
    local icon_part = ""
    if icon ~= "" and icon_hl then
        icon_part = string.format("%%#%s#%s %%#WinBar#", icon_hl, icon)
    end

    local modified = vim.bo.modified and " [+]" or ""
    return string.format(" %s%s%s ", icon_part, name, modified)
end

_G.CustomUI = {
    statusline = M.statusline,
    winbar = M.winbar,
}

vim.o.statusline = "%!v:lua.CustomUI.statusline()"
vim.o.winbar = "%!v:lua.CustomUI.winbar()"

return M
