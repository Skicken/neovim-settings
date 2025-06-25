vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<F5>", ":!g++ % -o %:r <cr>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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


vim.keymap.set("n", "dc", function()
    vim.cmd([[
        %s/^\s*\(\/\/\|#\|--\).*//g
    ]])
end, { desc = "Delete comments from the file" })



