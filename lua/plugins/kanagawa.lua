-- local isKanagawa = function() return vim.startswith(vim.env.NVIM_COLORSCHEME, "kanagawa") end

return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  priority = 1000,
  lazy = false,
  enabled = true,
  opts = function()
    return {
      compile = true, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurl undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "lotus",
      background = { -- map the value of 'background' option to a theme
        dark = "wave",
        light = "lotus",
      },
    }
  end,
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd("KanagawaCompile")
    vim.cmd.colorscheme("kanagawa")
  end,
}
