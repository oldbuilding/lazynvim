-- lua/config/lsp/bashls.lua
local M = {}

M.bashls = {
  filetypes = { "sh", "bash" },
  -- Additional settings from:
  --   https://github.com/bash-lsp/bash-language-server
  cmd = { "bash-language-server", "start" },
}

return M
