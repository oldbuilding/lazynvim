return {
  "nvim-treesitter/nvim-treesitter",
  config = function(_, opts)
    -- Just call your big config file, passing LazyVim’s opts:
    require("config.treesitter").setup(opts)
  end,
}

-- if true then return {} end
--
-- return {
--   "nvim-treesitter/nvim-treesitter",
--   -- version = treesitter_version, -- master, must be >0.9.2
--   -- branch = (treesitter_version == nil) and 'master' or nil,
--   build = function(_)
--     -- :TSUpdateSync (blocks UI)
--     (require("nvim-treesitter.install").update({ with_sync = true }))()
--   end,
--   event = "VeryLazy", -- lazy, or on demand (vim.treesitter call) via ftplugin
--   init = function()
--     -- Ensure conda's custom compiler is never used (via $CC);
--     -- conda's gcc can make treesitter parsers and neovim crash
--     -- Note: this needs to be done in init, before importing nvim-treesitter
--     -- See nvim-treesitter/nvim-treesitter#5623
--     if vim.fn.executable("/usr/bin/gcc") > 0 then
--       vim.env.CC = "/usr/bin/gcc"
--       vim.env.GCC = "/usr/bin/gcc"
--     end
--   end,
--   opts_extend = { "ensure_installed" },
--   ---@type TSConfig
--   ---@diagnostic disable-next-line: missing-fields
--   opts = {
--     ensure_installed = {
--       "bash",
--       "c",
--       "json",
--       "jsonc",
--       "lua",
--       "luadoc",
--       "luap",
--       "markdown",
--       "printf",
--       "python",
--       "regex",
--       "toml",
--       "xml",
--       "yaml",
--     },
--   },
--   config = function() require("config.treesitter").setup(opts) end,
-- }
