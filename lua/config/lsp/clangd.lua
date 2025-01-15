-- lua/config/lsp/clangd.lua
local M = {}

-- Original snippet says:
--   capabilities.offsetEncoding = "utf-8"
-- That’s it. Possibly add other default clangd flags here if you like:
M.clangd = {
  capabilities = {
    offsetEncoding = "utf-8",
  },
  -- Additional examples:
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname) or require("lspconfig.util").path.dirname(fname)
  end,
}

return M
