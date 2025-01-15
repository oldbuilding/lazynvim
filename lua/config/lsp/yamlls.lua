-- lua/config/lsp/yamlls.lua
local M = {}

M.yamlls = {
  -- Original snippet shows:
  --   yaml = { keyOrdering = false }
  settings = {
    yaml = {
      keyOrdering = false,
      -- Possibly more config here:
      format = { enable = true },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
    },
  },
}

return M
