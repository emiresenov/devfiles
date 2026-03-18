vim.keymap.set("n", "<C-Left>", "<C-w>>")
vim.keymap.set("n", "<C-Right>", "<C-w><")
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Down>", "<C-w>-")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("v", "<leader>cf", ":!clang-format<CR>", { silent = true })