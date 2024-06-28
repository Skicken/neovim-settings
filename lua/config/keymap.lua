vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<F5>", ":!g++ % -o %:r <cr>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- buffer navigation
vim.keymap.set("n", "[b", vim.cmd.bp, { desc = "Go to previous buffer" })
vim.keymap.set("n", "]b", vim.cmd.bn, { desc = "Go to next buffer" })

vim.keymap.set("n", "[b", vim.cmd.bp, { desc = "Go to previous buffer" })
vim.keymap.set("n", "]b", vim.cmd.bn, { desc = "Go to next buffer" })

vim.keymap.set("n", "dx", '"_dd', { desc = "delete line" })

vim.keymap.set("n", "[g", "g;", { desc = "Go to previous edit position" })
vim.keymap.set("n", "]g", "g,", { desc = "Go to next edit position" })
