return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.preset = "helix" -- "classic", "modern", "helix"
    opts.icons = {
      separator = " │",
      breadcrumb = ">",
    }
    opts.win = {
      height = {
        max = math.huge,
      },
      padding = { 0, 2 }, -- Add padding around the popup
    }
    opts.layout = {
      width = { min = 20 },
      spacing = 2,
    }

    -- opts.spec = {
    --   {
    --     mode = { "n", "v" },
    --     { "<leader>t", group = "Hotkeys" },
    --     { "gs", group = "surround" },
    --   },
    -- }

    return opts
  end,
}
