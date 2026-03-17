local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write", silent = true })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", silent = true })
map("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit all", silent = true })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })
map("n", "<leader>p", '"+p', { desc = "Paste from system" })

map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer", silent = true })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })

map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>", { desc = "Clear search", silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize up", silent = true })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize down", silent = true })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize left", silent = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize right", silent = true })

map("n", "<leader>uI", function()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
