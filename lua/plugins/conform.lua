return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- Use a sub-list to run only the first available formatter
                cpp = { "clang-format" },
            },

            vim.keymap.set("n", "<leader>ff", function()
                vim.lsp.buf.format();
            end, { desc = "format code" }),
        })
        require("conform").formatters.prettier = {
            prepend_args = { "--tab-width", "4" },
        }
        require("conform").formatters.clang = {
            prepend_args = { "--tab-width", "4" },
        }
    end,
}
