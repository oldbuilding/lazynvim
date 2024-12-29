-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n" }, ":", ";", { desc = "Swap ; with :", silent = true, noremap = true })
vim.keymap.set({ "n" }, ";", ":", { desc = "Swap : with ;", silent = true, noremap = true })
-- vim.keymap.set({ "n" }, "<Leader>w", "<Cmd>wall<CR>", { desc = "Save All", expr = true, silent = true })
-- vim.keymap.set({ "n" }, "<Leader>q", "<Cmd>confirm wall<CR><Cmd>confirm qall!<CR>", { desc = "Quit All", expr = true, silent = true })
