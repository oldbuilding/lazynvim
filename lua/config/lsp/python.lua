-- lua/config/lsp/python.lua
local M = {}

--------------------------------------------------------------------------------
-- BASEDPYRIGHT / PYRIGHT
--------------------------------------------------------------------------------
-- In your original config, these are the 'basedpyright' and 'pyright' blocks.
-- They share a function that returns settings for analysis.

local function pyright_opts(setup_name)
  return {
    settings = {
      [setup_name] = {
        analysis = {
          -- For details, see:
          --   https://github.com/microsoft/pyright/blob/main/docs/settings.md
          --   https://detachhead.github.io/basedpyright/
          extraPaths = { "./python" },
          typeCheckingMode = "standard", -- off, basic, standard, strict, all
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          diagnosticsMode = "openFilesOnly", -- or "workspace"
          diagnosticSeverityOverrides = {
            reportUnknownMemberType = false,
            reportUnknownArgumentType = false,
            -- reportUnusedClass = "warning",
            -- reportUnusedFunction = "warning",
            reportUndefinedVariable = false, -- ruff can handle this (F822)
          },
        },
        -- If you want to force a python binary:
        pythonPath = vim.fn.exepath("python3"),
      },
    },
  }
end

-- 'basedpyright' uses the same settings as 'pyright', but you prefer it
-- if installed. This is how we automatically disable standard pyright if
-- basedpyright is available.
M.basedpyright = function()
  -- If you want to skip standard pyright:
  -- (In your old config, it sets lsp_setup_opts["pyright"] = false)
  return pyright_opts("basedpyright")
end

M.pyright = function()
  -- If basedpyright is installed, we skip setting up normal pyright.
  local mr = require("mason-registry")
  if mr.is_installed("basedpyright") then
    -- Return false to disable standard pyright
    return false
  end
  return pyright_opts("python")
end

--------------------------------------------------------------------------------
-- RUFF
--------------------------------------------------------------------------------
-- Your original config had an lsp_setup_opts["ruff"] = function() ... end
-- Below are all the default options from your snippet, plus on_init logic.

M.ruff = {
  -- The main `.setup()` for ruff can consume these fields
  init_options = {
    -- https://github.com/astral-sh/ruff-lsp#settings
    settings = {
      fixAll = true,
      organizeImports = false, -- let isort handle import organizes if you prefer
      args = {
        "--preview", -- use experimental features
        "--ignore",
        table.concat({
          "E111", -- indentation-with-invalid-multiple
          "E114", -- indentation-with-invalid-multiple-comment
          "E402", -- module-import-not-at-top-of-file
          "E501", -- line-too-long
          "E702", -- multiple-statements-on-one-line-semicolon
          "E731", -- lambda-assignment
          "F401", -- unused-import
        }, ","),
      },
    },
  },
  capabilities = {
    general = {
      -- Force 'utf-16' to avoid conflict with Pyright
      -- https://github.com/astral-sh/ruff/issues/14483
      positionEncodings = { "utf-16" },
    },
  },
}

-- If you want to handle on_init for ruff (e.g. disable ruff hover):
M.ruff_on_init = function(client, _)
  if client.server_capabilities then
    -- Disable ruff's hover provider, preferring Pyright
    client.server_capabilities.hoverProvider = false
    -- Also disable ruff's formatting provider, if you prefer black/yapf
    client.server_capabilities.documentFormattingProvider = false
  end
end

return M
