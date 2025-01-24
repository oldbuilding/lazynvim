vim.api.nvim_create_autocmd("BufLeave", {
  callback = function() vim.b.last_cursor = vim.fn.getpos(".") end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.b.gast_cursor then vim.fn.setpos(".", vim.b.last_cursor) end
  end,
})

vim.keymap.set({ "n" }, "<M-b>", "<C-o>", { desc = "Jump back" })
vim.keymap.set({ "n" }, "<M-m>", "<C-i>", { desc = "Jump forward" })
vim.keymap.set({ "n" }, "<M-8>", "g,", { desc = "Goto [count] next position in change list" })
vim.keymap.set({ "n" }, "<M-9>", "g;", { desc = "Goto [count] prev position in change list" })

vim.keymap.set({ "n" }, "H", "<Cmd>bprevious<CR>", { desc = "Previous buffer (position)" })
vim.keymap.set({ "n" }, "L", "<Cmd>bnext<CR>", { desc = "Next buffer (position)" })

vim.keymap.set({ "n" }, "gi", "`^", { desc = "Go to last insert location (normal mode)" })

-- For cycling through more editing locations, you can explore plugins like vim-repeat or gitsigns.nvim for Git-based changes.
-- vim.keymap.set({ "n" }, "<leader>[", "'[", { desc = "Jump to start of last change" })
-- vim.keymap.set({ "n" }, "<leader>]", "']", { desc = "Jump to end of last change" })
