if true then return {} end
return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "ruff",
      "basedpyright",
    },
  },
}
