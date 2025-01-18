return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- etc. plus whichever you need: lsp-status, nvim-navic, fidget, etc.
  },
  config = function(_, opts)
    -- your aggregator’s main entry:
    require("config.lsp").setup_lsp()
    opts = opts or {}
    opts = {
      servers = {
        python = {
          { "<leader>cc", require("config.lsp.python").python_ruff_actions_and_save, desc = "Ruff Fixes" },
          { "<leader>xr", "<Cmd>LspRestart basedpyright ruff<CR>", desc = "Lsp Restart *" },
        },
      },
    }
  end,
}
