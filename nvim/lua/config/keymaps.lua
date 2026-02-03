-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = false })

local function copy_relative_path()
    -- Absolute path of current buffer (empty for [No Name])
    local buf = vim.api.nvim_buf_get_name(0)
    if buf == "" then
        vim.notify("No file name for current buffer", vim.log.levels.WARN)
        return
    end

    -- LazyVim usually sets cwd to project root (via rooter).
    -- This makes the path relative to that root.
    local rel = vim.fn.fnamemodify(buf, ":.")

    -- Put into clipboard register (requires +clipboard support)
    vim.fn.setreg("+", rel)
    vim.fn.setreg('"', rel) -- also put in unnamed register for convenience

    vim.notify("Copied: " .. rel)
end

vim.keymap.set("n", "<leader>cp", copy_relative_path, {
    desc = "Copy relative file path to clipboard",
})
