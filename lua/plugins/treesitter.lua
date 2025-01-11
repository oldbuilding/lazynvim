if true then return {} end

return {
  "nvim-treesitter/nvim-treesitter",
  opts_extend = { "ensure_installed" },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "printf",
      "python",
      "regex",
      "toml",
      "xml",
      "yaml",
    },
  },
}
