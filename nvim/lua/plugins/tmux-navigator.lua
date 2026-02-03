return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false, -- load it immediately
        init = function()
            -- Disable LazyVim’s default <C-h/j/k/l> window navigation
            vim.g.tmux_navigator_no_mappings = 1

            -- Optional: custom keymaps for tmux + nvim navigation
            local opts = { silent = true, noremap = true }
            vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
            vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
            vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
            vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
        end,
    },
}
