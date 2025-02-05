return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.preset = "modern" -- "classic", "modern", "helix"
    opts.icons = {
      separator = " │",
      breadcrumb = ">",
    }
    -- opts.win = {
    --   height = {
    --     max = math.huge,
    --   },
    --   padding = { 0, 2 }, -- Add padding around the popup
    -- }
    opts.win = {
      height = {
        max = 10, -- Restricts max height for better bottom placement
      },
      title = true,
      title_pos = "center",
      col = 0.5,
      padding = { 0, 2 },
      -- position = { row = "95%", col = "50%" }, -- Moves it to the bottom center
      -- anchor = "S", -- Anchors from the bottom
    }
    opts.layout = {
      align = "center",
      width = { min = 20, max = 30 },
      spacing = 1,
    }
    -- opts.modes = {
    --     i = false,
    --     x = false, -- Visual mode
    --     s = false, -- Select mode
    --     o = false, -- Operator pending mode
    --     t = false, -- Terminal mode
    --     c = false, -- Command mode
    -- }
    opts.plugins = {
      spelling = {
        enabled = false,
      },
    }
    opts.spec = vim.tbl_deep_extend("force", opts.spec or {}, {
      {
        mode = "n", -- Normal mode
        "<leader>cf",
        function()
          vim.lsp.buf.format({ async = false }) -- Ensure formatting completes
          vim.cmd("write") -- Save file after formatting
        end,
        desc = "Format and Save",
      },
    })
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
