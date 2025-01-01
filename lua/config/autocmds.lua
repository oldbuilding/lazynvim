-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.cmd([[autocmd VimEnter * highlight URL ctermfg=Blue guifg=Blue]])

vim.cmd([[autocmd VimEnter * highlight URL ctermfg=Blue guifg=Blue]])

vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.fn.expand("<afile>"))
    if ok and stats and (stats.size > 1024 * 500 or vim.api.nvim_buf_line_count(0) > 10000) then
      vim.cmd("setlocal foldmethod=manual")
      vim.cmd("syntax off")
      vim.cmd("filetype off")
      -- Disable Treesitter or other heavy plugins here
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function() vim.lsp.buf.format({ async = true }) end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function() require("utils.logging").notify("actual colorscheme " .. (vim.g.colors_name or "OOF!"), vim.log.levels.INFO) end,
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() vim.notify("Colorscheme changed to: " .. (vim.g.colors_name or "none"), vim.log.levels.INFO) end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() vim.notify("Restored colorscheme: " .. (vim.g.colors_name or "none"), vim.log.levels.INFO) end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if not vim.g.colors_name then
      vim.cmd.colorscheme("tokyonight-day") -- Set your default fallback colorscheme
    end
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "ColorschemeSavePost",
--   callback = function()
--     require("utils.logging").notify("Colorsaver saved colorscheme: " .. (vim.g.colors_name or "unknown"), "INFO")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "*", -- Catch all patterns
--   callback = function(event)
--     local pattern = event.match or "nil"
--     if pattern:match("^Lazy") then
--       -- Skip events starting with "Lazy"
--       return
--     end
--     require("utils.logging").notify("Triggered User event: " .. event.event .. ", pattern: " .. (event.match or "nil"), "DEBUG")
--   end,
-- })

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   -- log all colorscheme events
--   callback = function()
--     require("utils.logging").notify("ColorScheme triggered: " .. (vim.g.colors_name or "unknown"), "INFO")
--   end,
-- })
