return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- etc. plus : lsp-status, nvim-navic, fidget, etc.
  },
  -- opts = {
  --   servers = {
  --     basedpyright = {
  --       keys = {
  --         { "<leader>cc", require("config.keymaps.lsp").python_ruff_actions_and_save(), desc = "Ruff Fixes" },
  --         { "<leader>cr", "<Cmd>LspRestart basedpyright ruff<CR>", desc = "Lsp Restart *" },
  --         { "<leader>ch", vim.lsp.buf.hover, desc = "Hover Documentation" },
  --       },
  --     },
  --   },
  -- },
  config = function(_, _) require("config.lsp").setup_lsp() end,
}
