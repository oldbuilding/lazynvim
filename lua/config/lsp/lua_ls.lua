-- lua/config/lsp/lua_ls.lua
local M = {}

-- Original snippet from `config/lsp.lua`: lsp_setup_opts["lua_ls"]
-- We also had an on_init that disables formatting.

M.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- or "Lua 5.1" etc.
        pathStrict = true,
      },
      diagnostics = {
        -- For example, ignoring false positives
        disable = { "redundant-parameter", "duplicate-set-field" },
      },
      hint = (function()
        if vim.fn.has("nvim-0.10") > 0 then
          return {
            enable = true,
            paramType = true,
            paramName = "Literal",
            arrayIndex = "Auto",
            setType = true,
          }
        end
        return nil
      end)(),
      completion = { callSnippet = "Disable" },
      workspace = {
        maxPreload = 8000,
        checkThirdParty = false, -- stop prompting about "configure your work environment"
        ignoreDir = { ".*", "vim/plugged", "config/nvim", "nvim/lua" },
        library = (function()
          local library = {}
          if vim.fn.has("mac") > 0 then
            -- Hammerspoon EmmyLua support
            local path = vim.fn.expand("$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations")
            library[path] = true
          end
          return library
        end)(),
      },
    },
  },
  -- Additional custom config if you want
  on_init = function(client, _)
    if client.server_capabilities then client.server_capabilities.documentFormattingProvider = false end
  end,
}

return M
