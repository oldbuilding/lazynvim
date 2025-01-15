if true then return {} end
return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "basedpyright",
      "bashls",
      "clangd",
      "lua_ls",
      "ruff",
      "shfmt",
      "stylua",
      "yamlls",
    },
  },
}
