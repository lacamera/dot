local opt = vim.opt

opt.mouse = "a"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.termguicolors = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = false

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes:1"
opt.statuscolumn = "%s%C%=%{v:relnum ? v:relnum : v:lnum} "

opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 6
opt.sidescrolloff = 8
opt.cursorline = true
opt.colorcolumn = "100"

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.confirm = true
opt.updatetime = 200
opt.timeoutlen = 300

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.inccommand = "split"

opt.laststatus = 3
opt.cmdheight = 0
opt.showmode = false
opt.pumblend = 10
opt.winblend = 0
opt.conceallevel = 2
opt.virtualedit = "block"
opt.jumpoptions = "view"
opt.smoothscroll = true

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo"

opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    diff = "╱",
}

opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

opt.shortmess:append({ I = true, W = true, c = true, C = true })
opt.completeopt = { "menu", "menuone", "noselect" }

pcall(function()
    vim.o.winborder = "rounded"
end)
