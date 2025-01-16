--------------------------------------------------------------------------------
-- lua/config/lsp/init.lua
--------------------------------------------------------------------------------
local M = {}

--------------------------------------------------------------------------------
-- 1) Common on_attach callback
--    (Keymaps, signature help, navic, etc.)
--------------------------------------------------------------------------------
local function on_attach(client, bufnr)
  -- Example: If you use lsp_signature:
  -- require("lsp_signature").on_attach({ bind = true }, bufnr)

  -- If you use lsp-status:
  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.on_attach(client)
  end

  -- Example: nvim-navic for code context
  if client.server_capabilities.documentSymbolProvider then
    local ok_navic, navic = pcall(require, "nvim-navic")
    if ok_navic then
      navic.attach(client, bufnr)
    end
  end

  -- Example: set up buffer-local mappings
  local nmap = function(lhs, rhs, desc)
    if desc then desc = "[LSP] " .. desc end
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Definitions, references, etc.
  nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
  nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Find references")
  nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
  nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol")
  nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")

  -- Diagnostics navigation
  nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev diagnostic")
  nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
end

--------------------------------------------------------------------------------
-- 2) Additional server-specific config
--    Put big config blocks here or require them from separate files.
--    For example, if you have `lua/config/lsp/lua_ls.lua`,
--    you can do:  local lua_ls = require("config.lsp.lua_ls").lua_ls
--------------------------------------------------------------------------------
local servers_config = {
  basedpyright = require("config.lsp.python").basedpyright,
  ruff = require("config.lsp.python").ruff,
  pyright = require("config.lsp.python").pyright,
  lua_ls = require("config.lsp.lua_ls").lua_ls,
  yaml_language_server = require("config.lsp.yamlls").yaml_language_server,
  clangd = require("config.lsp.clangd").clangd,
  bashls = require("config.lsp.bashls").bashls,
}

--------------------------------------------------------------------------------
-- 3) A helper to set up a single server
--    Checks if there's a config entry in `servers_config`,
--    merges with your common on_attach/capabilities.
--------------------------------------------------------------------------------
local function setup_one_server(server_name)
  local lspconfig = require("lspconfig")

  local config = servers_config[server_name] or {}
  -- If it's a function, call it to produce a table.
  if type(config) == "function" then
    config = config()
    if config == false then
      return -- e.g. if we decide to disable this server
    end
  end

  -- Add your common on_attach/capabilities:
  config.on_attach = on_attach
  -- e.g. config.capabilities = require("cmp_nvim_lsp").default_capabilities()

  lspconfig[server_name].setup(config)
end

--------------------------------------------------------------------------------
-- 4) Diagnostics / Handlers / Misc
--------------------------------------------------------------------------------
function M.setup_diagnostics()
  -- Example: a minimal approach
  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded" },
    virtual_text = {
      spacing = 4,
      prefix = "●",
    },
  })
end

function M.setup_handlers()
  -- Example: custom border for hover
  local border_hover = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    local bufnr, winnr = border_hover(err, result, ctx, config)
    if winnr ~= nil then
      vim.api.nvim_win_set_option(winnr, "winblend", 10)
    end
    return bufnr, winnr
  end
end

--------------------------------------------------------------------------------
-- 5) Main function to set up everything:
--    - Mason & Mason-LSPconfig
--    - Install + configure LSP servers
--    - Diagnostics + handlers
--------------------------------------------------------------------------------
function M.setup_lsp()
  -- A) Mason
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  -- B) Mason-lspconfig: auto-install some servers
  require("mason-lspconfig").setup({
    ensure_installed = {
      "basedpyright",
      "bashls",
      "clangd",
      "lua_ls",
      "ruff",
      "yamlls",
      -- other LSP tools...
      -- define NON-lsp tooling in plugins/mason.lua with require("mason").setup({ ... })
    },
  })

  -- C) For each installed server, do lspconfig[...] setup
  local mason_lspconfig = require("mason-lspconfig")
  local installed = mason_lspconfig.get_installed_servers()
  for _, server_name in ipairs(installed) do
    setup_one_server(server_name)
  end

  -- D) If new servers are installed at runtime, set them up
  local registry = require("mason-registry")
  for _, pkg in ipairs(registry.get_installed_packages()) do
    pkg:on("install:success", vim.schedule_wrap(function()
      local mapped_name = mason_lspconfig.get_mapped_server_name(pkg.name)
      if mapped_name then
        setup_one_server(mapped_name)
      end
    end))
  end

  -- E) Setup extra stuff
  M.setup_diagnostics()
  M.setup_handlers()
end

return M

