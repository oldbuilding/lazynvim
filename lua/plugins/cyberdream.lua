return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  opts = function(_, _)
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = true,
      terminal_colors = true,
      cache = false, -- generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
      variant = "light",
      -- Disable or enable colorscheme extensions
      extensions = {
        alpha = true,
        cmp = true,
        dashboard = true,
        fzflua = true,
        gitpad = true,
        gitsigns = true,
        grapple = false,
        grugfar = false,
        heirline = false,
        hop = false,
        indentblankline = false,
        kubectl = false,
        lazy = true,
        leap = false,
        markdown = true,
        markview = false,
        mini = true,
        noice = true,
        notify = false,
        rainbow_delimiters = true,
        telescope = false,
        treesitter = true,
        treesittercontext = true,
        trouble = true,
        whichkey = true,
      },
    })
  end,
}
