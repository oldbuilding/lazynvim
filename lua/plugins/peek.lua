if true then return {} end

-- return {
--   "toppair/peek.nvim",
--   event = { "VeryLazy" },
--   build = "deno task --quiet build:fast",
--   config = function()
--     require("peek").setup({
--       app = "browser", -- or "webview"
--       auto_load = true, -- whether to automatically load preview when
--       close_on_bdelete = true, -- close preview window on buffer delete
--       syntax = true, -- enable syntax highlighting, affects performance
--       theme = "dark", -- 'dark' or 'light'
--       update_on_change = true,
--     })
--     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
--     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
--   end,
-- }
