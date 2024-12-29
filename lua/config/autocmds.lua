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
