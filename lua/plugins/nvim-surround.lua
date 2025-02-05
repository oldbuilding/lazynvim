return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "<leader>sa",
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = "<leader>s",
        visual_line = "<leader>S",
        delete = "<leader>sd",
        change = "<leader>sr",
      },
      aliases = {
        ["i"] = "]", -- Index
        ["r"] = ")", -- Round
        ["b"] = "}", -- Brackets
      },
      move_cursor = false,
    })
  end,
  -- keys = {
  --   {
  --     "<leader>sw",
  --     "<leader>saiw",
  --     desc = "Surround word",
  --   },
  --   {
  --     "<leader>sW",
  --     "<leader>saiW",
  --     desc = "Surround WORD",
  --   },
  -- {
  --   "<leader>s'",
  --   "<leader>srq'",
  --   desc = "Surround 'word'",
  -- },
  -- {
  --   '<leader>s"',
  --   '<leader>srq"',
  --   desc = 'Surround "word"',
  -- },
  -- {
  --   "<leader>sp",
  --   "<leader>srq)",
  --   desc = "Surround (word)",
  -- },
  -- {
  --   "<leader>sP",
  --   "<leader>srq(",
  --   desc = "Surround ( word )",
  -- },
  -- {
  --   "<leader>sb",
  --   "<leader>srq]",
  --   desc = "Surround [word]",
  -- },
  -- {
  --   "<leader>sB",
  --   "<leader>srq[",
  --   desc = "Surround [ word ]",
  -- },
  -- {
  --   "<leader>sc",
  --   "<leader>srq}",
  --   desc = "Surround {word}",
  -- },
  -- {
  --   "<leader>sC",
  --   "<leader>srq{",
  --   desc = "Surround { word }",
  -- },
  -- },
}
