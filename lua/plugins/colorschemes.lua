return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },
  {
    "https://gitlab.com/bartekjaszczak/finale-nvim",
    priority = 1000,
    config = function()
      -- Activate the theme
      vim.cmd.colorscheme("finale")
    end,
  },
  {
    "kordyte/collaterlie-nvim",
  },
  {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = false,
      underline = false,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = true,
      invert_signs = true,
      invert_tabline = true,
      invert_intend_guides = true,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  {
    "horanmustaplot/xcarbon.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() vim.cmd("colorscheme xcarbon") end,
  },
  {
    "ofirgall/ofirkai.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("ofirkai").setup({
        theme = "dark_blue", -- Choose theme to use, available themes: 'dark_blue'
        scheme = require("ofirkai").scheme, -- Option to override scheme
        custom_hlgroups = {}, -- Option to add/override highlight groups
        remove_italics = false, -- Option to change all the italics style to none
      })
    end,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "fenetikm/falcon",
    lazy = false,
    priority = 1000,
    falcon_background = 0,
    falcon_inactive = 1,
    -- config = function(_, _)
    --   require("falcon").setup({
    --   })
    -- end,
  },
  {
    "oxfist/night-owl.nvim",
    version = false,
    opts = function(_, _)
      require("night-owl").setup({
        bold = true,
        italics = true,
        underline = true,
        undercurl = true,
        transparent_background = false,
        vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = "Yellow" }),
      })
    end,
  },
  {

    "ray-x/starry.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      local colors = require("starry.colors")
      require("starry").setup({
        border = true, -- Split window borders
        hide_eob = true, -- Hide end of buffer
        italics = {
          comments = true, -- Italic comments
          strings = false, -- Italic strings
          keywords = false, -- Italic keywords
          functions = true, -- Italic functions
          variables = false, -- Italic variables
        },
        contrast = { -- Select which windows get the contrast background
          enable = true, -- Enable contrast
          terminal = true, -- Darker terminal
          filetypes = { "*", "*.py", "*.sh", "*.lua" }, -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
        },
        text_contrast = {
          lighter = true, -- Higher contrast text for lighter style
          darker = true, -- Higher contrast text for darker style
        },
        disable = {
          background = false, -- true: transparent background
          term_colors = false, -- Disable setting the terminal colors
          eob_lines = false, -- Make end-of-buffer lines invisible
        },
        style = {
          "emerald",
          disable = {}, -- a list of styles to disable, e.g. {'bold', 'underline'}
          fix = true,
          darker_contrast = true, -- More contrast for darker style
          daylight_switch = false, -- Enable day and night style switching
          deep_black = true, -- Enable a deeper black background
        },
        custom_colors = {
          -- variable = "#f797d7",
        },
        custom_highlights = {
          CursorLine = { bg = "#072408" },
          BufferLineBufferSelected = { bg = "#f27961", fg = "##eef5df", bold = true },
        },
      })
    end,
  },
  {
    "Verf/deepwhite.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        theme = "deepwhite",
        low_blue_light = true,
      }
    end,
    config = function(_, opts)
      require("deepwhite").setup(opts)
      vim.cmd.colorscheme("deepwhite")
    end,
  },
  { "savq/melange-nvim" },
  { "SebastianZaha/nvim-solar-paper" },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  { "echasnovski/mini.base16", version = false },
  { "rose-pine/neovim", version = false },
  { "xero/miasma.nvim", version = false },
  { "navarasu/onedark.nvim", version = false },
  { "sontungexpt/witch", version = false },
}
