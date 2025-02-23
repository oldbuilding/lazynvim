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
      title = false,
      title_pos = "center",
      col = 0.5,
      padding = { 0, 2 },
    }
    -- opts.layout = {
    --   align = "right",
    --   width = { min = 20, max = 40 },
    --   columns = 1,
    --   spacing = 1,
    -- }
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
      -- {
      --   mode = "n",
      --   "<leader>@",
      --   function()
      --     if vim.fn.reg_recording() ~= "" then
      --       vim.cmd("normal! @")
      --     else
      --       local reg = vim.fn.input("Macro register: ")
      --       if reg ~= "" then vim.cmd("normal! q" .. reg) end
      --     end
      --   end,
      --   desc = "Toggle Macro Recording",
      -- },
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
