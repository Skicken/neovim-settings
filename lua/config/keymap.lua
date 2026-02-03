vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float()
end, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist()
end, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "[b", vim.cmd.bp, { desc = "Go to previous edit buffer" })
vim.keymap.set("n", "]b", vim.cmd.bn, { desc = "Go to next edit buffer" })

vim.keymap.set("n", "<leader>b", ":b#<CR>", { desc = "Alternative buffer" })

vim.keymap.set("n", "dx", '"_dd', { desc = "delete line" })

vim.keymap.set("n", "[g", "g;", { desc = "Go to previous edit position" })
vim.keymap.set("n", "]g", "g,", { desc = "Go to next edit position" })

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "move line down(n)" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "move line up(n)" })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "move line up(v)" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "move line down(v)" })
