-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n" }, "<leader>fs", "<Cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set({ "n" }, "<leader>fS", "<Cmd>wall<CR>", { desc = "Save all buffers" })

vim.keymap.set({ "n" }, "<leader>uB", "<Cmd>set winblend=0<CR>", { desc = "Opaque!", silent = true, noremap = true })

vim.keymap.set({ "n" }, ":", ";", { desc = "Swap ; with :", silent = true, noremap = true })
vim.keymap.set({ "n" }, ";", ":", { desc = "Swap : with ;", silent = true, noremap = true })

--   -- Clear the message area first to avoid stale content
--   vim.cmd("echo ''")
--
--   -- Call `vim.show_pos` to populate the message area with position details
--   vim.show_pos()
--
--   -- Capture the latest message area content
--   local messages = vim.fn.execute("messages")
--   local lines = {}
--
--   -- Split captured messages into lines
--   for line in messages:gmatch("[^\r\n]+") do
--     vim.cmd("echo " .. line)
--     table.insert(lines, line)
--   end
--
--   -- Display the captured output in a floating window
--   if #lines == 0 then
--     vim.notify("No output from vim.show_pos", vim.log.levels.WARN)
--     return
--   end
--
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.bo[buf].modifiable = false -- Updated to use buffer-scoped options
--   vim.bo[buf].filetype = "markdown" -- Updated filetype setting
--   -- vim.api.nvim_buf_set_option(buf, "wrap", true)
--   ---@diagnostic disable-next-line: inject-field
--   vim.bo[buf].wrap = true
--
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--
--   local width = math.min(80, vim.o.columns - 4)
--   local height = math.min(#lines + 2, vim.o.lines - 4)
--   local row = math.floor((vim.o.lines - height) / 2)
--   local col = math.floor((vim.o.columns - width) / 2)
--
--   local win = vim.api.nvim_open_win(buf, true, {
--     relative = "editor",
--     width = width,
--     height = height,
--     row = row,
--     col = col,
--     style = "minimal",
--     border = "rounded",
--   })
--
--   -- Ensure the window remains open until manually closed
--   -- vim.api.nvim_win_set_option(win, "winblend", 10) -- Transparency
--   vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bd!<CR>", { noremap = true, silent = true })
-- end, { desc = "Inspect Position with Hover", silent = true, noremap = true })
