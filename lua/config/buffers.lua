vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(args)
    -- Check if this window is floating:
    local config = vim.api.nvim_win_get_config(0)
    if config and config.relative ~= "" then
      -- It's a floating window, force wrap
      vim.opt_local.wrap = true
    end
  end,
})

-- Suppose ConformInfo uses 'conform-info' as its filetype (hypothetical).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "conform-info",
  callback = function() vim.opt_local.wrap = true end,
})

-- vim.api.nvim_create_autocmd({ "TabEnter", "BufEnter" }, {
--   callback = function(args)
--     -- args.event tells you which event triggered this callback
--     local event_fired = args.event
--     if event_fired == "TabEnter" then
--       -- do something specific for TabEnter
--     else
--       -- do something else for BufEnter
--     end
--     -- or a single unified action for both
--     print("Triggered by: " .. event_fired)
--   end,
--   desc = "Combined autocommand for TabEnter and BufEnter",
-- })
