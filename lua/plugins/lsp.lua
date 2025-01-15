return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- etc. plus whichever you need: lsp-status, nvim-navic, fidget, etc.
  },
  config = function()
    -- your aggregator’s main entry:
    require("config.lsp").setup_lsp()
  end,
}
