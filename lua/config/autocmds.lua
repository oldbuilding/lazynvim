-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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

-- Format on save is handled by conform.nvim and custom keymaps
-- Removed duplicate format-on-save to avoid double formatting

vim.api.nvim_create_user_command("CopyMessages", function()
  local messages = vim.fn.execute("messages")
  vim.fn.setreg("+", messages) -- Copy to the system clipboard
  print("Messages copied to clipboard!")
end, {})

-- Removed broken VimResized autocmd that referenced undefined 'self'
-- This was likely meant for a different context (snacks notifier)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local current_colorscheme = vim.g.colors_name
    if current_colorscheme == nil or current_colorscheme == "night-owl" then
      vim.cmd.colorscheme("tokyonight-night") -- Set your default fallback colorscheme
      vim.notify("Colorscheme: " .. (vim.g.colors_name or "none"), vim.log.levels.DEBUG, { title = "Colorscheme" })
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = function() vim.cmd("checktime") end,
})
