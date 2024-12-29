---@type LazySpec
return {
  "codethread/qmk.nvim",
  ft = "dts",
  config = function()
    ---@module 'qmk'
    ---@type qmk.UserConfig
    local config_ = {
      name = "LAYOUT_preonic_grid", -- (aka: "LAYOUT_ortho_5x12")
      layout = {
        "x x x x x x x x x x x x",
        "x x x x x x x x x x x x",
        "x x x x x x x x x x x x",
        "x x x x x x x x x x x x",
        "x x x x x x x x x x x x",
      },
      variant = "qmk",
      auto_format_pattern = "*.keymap",
    }
    require("qmk").setup(config_)
  end,
}
