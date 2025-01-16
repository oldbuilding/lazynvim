-- if true then return {} end

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.format_after_save = nil
    opts.formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
      lua = {"stylua"},
      bash = {"shfmt"},
    }
  end
}
