return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.format_on_save = true
    opts.formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
    }
  end,
}
