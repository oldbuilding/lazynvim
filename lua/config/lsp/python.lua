-- lua/config/lsp/python.lua
local M = {}

local function find_python_venv()
  -- 1) Get your current project root.
  --    If you have more advanced logic for "project root",
  --    use that instead of `vim.fn.getcwd()`.
  local root = vim.fn.getcwd()

  -- 2) Check each candidate directory for a `bin/python` that is executable
  for _, dirname in ipairs({ ".venv", ".pie" }) do
    local candidate = root .. "/" .. dirname .. "/bin/python"
    if vim.fn.executable(candidate) == 1 then
      require("utils.logging").notify("pythonpath candidate found " .. candidate)
      return candidate
    end
  end

  -- 3) Check if there's an active venv from environment variable VIRTUAL_ENV
  local active_venv = os.getenv("VIRTUAL_ENV")
  if active_venv then
    local candidate = active_venv .. "/bin/python"
    if vim.fn.executable(candidate) == 1 then
      require("utils.logging").notify("pythonpath active venv candidate found " .. candidate)
      return candidate
    end
  end
  -- 4) Fallback to system python3 in PATH
  return vim.fn.exepath("python3")
end

--------------------------------------------------------------------------------
-- BASEDPYRIGHT / PYRIGHT
--------------------------------------------------------------------------------
-- In your original config, these are the 'basedpyright' and 'pyright' blocks.
-- They share a function that returns settings for analysis.

M.basedpyright = function()
  return {
    capabilities = {
      general = {
        positionEncodings = { "utf-16" },
      },
    },
    settings = {
      basedpyright = {
        analysis = {
          -- For details, see:
          --   https://github.com/microsoft/pyright/blob/main/docs/settings.md
          --   https://detachhead.github.io/basedpyright/
          extraPaths = { "./python", ".venv" },
          typeCheckingMode = "off", -- off, basic, standard, strict, all
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          diagnosticsMode = "openFilesOnly", -- or "workspace"
          diagnosticSeverityOverrides = {
            reportAny = "none",
            reportDeprecated = "hint",
            reportImplicitStringConcatenation = "none",
            reportMissingParameterType = "none",
            reportMissingTypeArgument = "none",
            reportMissingTypeStubs = "none",
            reportUnknownArgumentType = "none",
            reportUnknownLambdaType = "none",
            reportUnknownMemberType = "none",
            reportUnknownParameterType = "none",
            reportUnknownVariableType = "none",
            reportUnusedCallResult = "none",
            reportUndefinedVariable = "none", -- ruff can handle this (F822)
            reportUninitializedInstanceVariable = "none",
            reportUnannotatedClassAttribute = "none",
          },
        },
      },
    },
    pythonPath = find_python_venv(),
  }
end

M.pyright = function()
  return false
  -- -- If basedpyright is installed, we skip setting up normal pyright.
  -- local mr = require("mason-registry")
  -- if mr.is_installed("basedpyright") then
  --   -- Return false to disable standard pyright
  --   return false
  -- end
  -- return pyright_opts("python")
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
      organizeImports = true, -- let pymple do
      lint = {
        enable = true,
      },
      format = {
        preview = true,
      },
      args = {
        "--preview", -- use experimental features
        "--ignore",
        "--add-noqa",
        "--watch",
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
