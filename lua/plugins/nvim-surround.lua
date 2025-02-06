return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "<leader>Ga", -- Surround a motion (`saaiw"` → "word")
        normal_cur = "<leader>Ga", -- Surround current line (same as normal)
        delete = "<leader>Gad", -- Delete surrounding (`sad"` → removes `word`)
        change = "<leader>Gac", -- Change surrounding (`sac"` → change surrounding)
        visual = "<leader>Gav", -- Surround selection in visual mode
        visual_line = "<leader>Gal", -- Surround entire line in visual mode
      },
      -- All mappings start with sa (Surround Actions):
      -- 	•	saa" → Surround a word with " (instead of ysiw")
      -- 	•	sad" → Delete surrounding "
      -- 	•	sac" → Change surrounding "
      --
      -- Visual mode mappings:
      -- 	•	sav" → Surround visual selection with "
      -- 	•	sal" → Surround entire selected line.
      --
      -- Aliases allow using simpler keys:
      -- 	•	saa] works just like saa] (aliasing [ to ]).
      -- 	•	saa} is treated as saa} (aliasing { to }).
      -- 	•	saa' is treated as saa' (aliasing single quotes).
      aliases = {
        --   ["i"] = "]", -- Index
        --   ["r"] = ")", -- Round
        --   ["b"] = "}", -- Brackets
        -- Use "sa" as the prefix for all
        ["Ga]"] = "]", -- Index → `saa]`
        ["Ga0"] = ")", -- Round → `saa)`
        ["Ga9"] = "(", -- Round → `saa)`
        ["Ga}"] = "}", -- Brackets → `saa}`
        ["Ga'"] = "'", -- Single Quotes → `saa'`
        ['Ga"'] = '"', -- Double Quotes → `saa"`
        ["Ga<"] = "<", -- Angle Brackets → `saa<`
        ["Ga`"] = "`", -- Backticks → `saa``
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
