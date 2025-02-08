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
    "mathofprimes/nightvision-nvim",
    config = function(_, opts)
      require("nightvision").setup(opts)
      vim.cmd("colorscheme nightvision")
    end,
  },
  {
    "atelierbram/Base2Tone-nvim",
  },
  {
    "atelierbram/Base4Tone-nvim",
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "multiplex", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
      toggle_style_list = { "multiplex", "light" }, -- List of styles to toggle between
      transparent = false, -- Show/hide background
      dim_inactive = false, -- Dim inactive windows/buffers
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      code_style = {
        comments = { italic = true },
        conditionals = { bold = true },
        keywords = { italic = true },
        functions = { bold = true },
        namespaces = { italic = false },
        parameters = { italic = false },
        strings = {},
        variables = {},
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {}, -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = false, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
    config = function(_, opts)
      require("bamboo").setup(opts)
      require("bamboo").load()
    end,
  },
  -- {
  --   'projekt0n/caret.nvim',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   opts = {
  --       transparent = false,       -- Set to true to disable background setting
  --       inverted_signs = false,    -- Controls inverted Signcolumn highlighting
  --       styles = {                 -- Define styles for various syntax groups
  --         bold = true,
  --         italic = true,
  --         strikethrough = true,
  --         undercurl = false,
  --         underline = true,
  --       },
  --       inverse = {                -- Determines inverse highlights for different types
  --         match_paren = true,
  --         visual = true,
  --         search = true,
  --       },
  --     },
  --     mapping = {                  -- Configure key mappings
  --       toggle_bg = nil,           -- Assign a specific key for toggling background
  --     },
  --     groups = {},                 -- Override default highlight groups here
  --   }
  --   config = function()
  --     require('caret').setup(
  --     )
  --     vim.cmd('colorscheme caret')
  --   end,
  -- },
  {
    "bettervim/yugen.nvim",
    config = function() vim.cmd.colorscheme("yugen") end,
  },
  {
    "water-sucks/darkrose.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        styles = {
          bold = true, -- Enable bold highlights for some highlight groups
          italic = true, -- Enable italic highlights for some highlight groups
          underline = true, -- Enable underline highlights for some highlight groups
        },
      }
    end,
    config = function(_, opts)
      require("darkrose").setup(opts)
      vim.cmd.colorscheme("darkrose")
    end,
  },
  {
    "Skullamortis/forest.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "serene", -- The theme comes in three styles, `serene`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      }
    end,
    config = function(_, opts)
      require("forest").setup(opts)
      vim.cmd("colorscheme forest")
    end,
  },
  {
    "racagogi/mytilus",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        theme = "mytilus-light", -- can be light, dark or mytilus_dark
        options = {
          sideBarDim = true, --if false then sidebar bg is same normal
          statusBarRevers = true, --if false, statusBarRevers bg is d2_black,
          NCWindowDim = true, --if false, not current window bg is same normal
          -- "none", "bold", "italic"
          constant = "bold",
          str = "none",
          func = "bold",
          type = "italic",
          statement = "none",
          keyword = "italic",
        },
        overides = {}, -- ["@string"] = { fg = "#222222", italic = true },
      }
    end,
    config = function(_, opts)
      require("mytilus").setup(opts)
      vim.cmd("colorscheme mytilus-light")
    end,
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
          daylight_switch = true, -- Enable day and night style switching
          deep_black = true, -- Enable a deeper black background
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
