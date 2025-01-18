if true then return {} end

-- config/treesitter.lua
-- A cleaned-up and LazyVim-friendly version of the original file.
-- This merges your custom logic with LazyVim’s `opts`, so both sets
-- of configs coexist without duplication.
--
-- Usage: in your plugin spec:
--    config = function(_, opts)
--      require("config.treesitter").setup(opts)
--    end

local M = {}

-----------------------------------------------------------------------------
-- Internal state (like the original file).
-----------------------------------------------------------------------------

-- Attempt to re-install broken parsers automatically.
-- This is from the original config's "try_recover_parser_errors" logic.
local _recover_requested = false
local function try_recover_parser_errors(lang, err)
  if not err or (not err:match("[Ii]nvalid node type") and not err:match("[Ii]nvalid field") and not err:match("[Ii]nvalid capture")) then return false end

  -- Prevent repeated re-installs
  if _recover_requested then return false end
  _recover_requested = true

  -- Disable folding to avoid freeze
  vim.opt_global.foldexpr = "0"

  -- Force reinstall the parser
  local msg = ("Fatal error in treesitter parser (%s). Attempting re-install...\n%s"):format(lang, err)
  vim.notify(msg, vim.log.levels.ERROR, { title = "config/treesitter" })

  -- Reinstall asynchronously
  vim.schedule(function()
    vim.defer_fn(function()
      require("nvim-treesitter.install").commands.TSInstallSync["run!"](lang)
      require("nvim-treesitter.install").commands.TSUpdateSync.run()
      vim.notify(("Treesitter parser %s reinstalled. Please restart Neovim."):format(lang))
    end, 1000)
  end)
  return true
end

-----------------------------------------------------------------------------
-- Keymaps, extra commands, etc.
-----------------------------------------------------------------------------

function M.setup_keymap()
  -- If you don’t want to override default LazyVim bindings, you can skip this.
  -- Adjust to your preference.
  vim.keymap.set("n", "<leader>tsh", "<cmd>Inspect<CR>", { desc = "Treesitter Inspect" })
  vim.keymap.set("n", "<leader>i", "<cmd>Inspect<CR>", { desc = "Inspect Under Cursor" })

  -- Fallback to old playground if needed.
  vim.cmd([[ command! InspectTree :TSPlaygroundToggle ]])
end

-----------------------------------------------------------------------------
-- Primary Setup
-----------------------------------------------------------------------------

function M.setup(opts)
  local ts_configs = require("nvim-treesitter.configs")

  -- 1) Merge your custom highlight defaults into LazyVim’s `opts`.
  --    If you already set highlight somewhere else, tweak logic below:
  opts.highlight = opts.highlight or {}
  -- Example: override highlight.enable if not set by LazyVim
  if opts.highlight.enable == nil then opts.highlight.enable = true end
  -- Additional example: disable highlight for certain filetypes
  opts.highlight.disable = vim.tbl_deep_extend("force", opts.highlight.disable or {}, {
    "fzf",
    "GV",
    "gitmessengerpopup",
    "fugitive",
    "NvimTree",
  })
  -- Example: also keep extended regex for Python
  opts.highlight.additional_vim_regex_highlighting = { "python" }

  -- 2) If your original config wants to set ensure_installed, merge it here:
  -- NOTE: if your plugins/treesitter.lua already sets `opts.ensure_installed`,
  -- you can remove or comment out the block below to avoid duplication.
  opts.ensure_installed = opts.ensure_installed or {}
  local minimal_parsers = {
    "bash",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "vim",
    "yaml",
  }
  for _, lang in ipairs(minimal_parsers) do
    if not vim.tbl_contains(opts.ensure_installed, lang) then table.insert(opts.ensure_installed, lang) end
  end

  -- 3) If you want the playground module:
  opts.playground = opts.playground or {}
  opts.playground.enable = vim.fn.has("nvim-0.10") == 0 -- only if <0.10

  -- 5) Finally call the nvim-treesitter setup with merged opts
  ts_configs.setup(opts)

  -- 6) Optional: set up folding based on treesitter
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- 7) Keymaps from the original config
  M.setup_keymap()

  -- 8) Catch parser errors and attempt auto-recovery
  --    (If you prefer not to auto reinstall, you can remove this.)
  vim.api.nvim_create_autocmd("User", {
    pattern = "TSParserError",
    callback = function(args)
      local err = args.data and args.data.err or ""
      local lang = args.data and args.data.lang or "?"
      try_recover_parser_errors(lang, err)
    end,
  })
end

return M
