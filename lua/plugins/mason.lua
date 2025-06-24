return {
  "williamboman/mason.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = true,
  opts_extend = { "ensure_installed" },
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "shfmt",
      "stylua",
      -- other non-LSP tools...
      -- define lsp tooling in config/lsp/... with require("mason-lspconfig").setup({ ... })
    })
  end,
}
