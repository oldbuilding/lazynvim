return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
        save_on_ui_close = true,
        key = function()
          -- Use the current git project root, or the current working directory as the key
          local cwd = require("utils.paths").find_project_root()
          return cwd
        end,
      },
    },
    keys = function()
      local keys_ = {
        --
        -- disable default bindings
        --
        { "<leader>H", false },
        { "<leader>1", false },
        { "<leader>2", false },
        { "<leader>3", false },
        { "<leader>4", false },
        { "<leader>5", false },
        --
        -- add custom bindings
        --
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon",
        },
        {
          "<leader>hh",
          function()
            require("utils.logging").notify("Triggered <leader>h<leader>")
            -- require("harpoon"):list()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
            require("utils.logging").notify(debug.traceback())
          end,
          desc = "Harpoon Menu",
        },
        {
          "<leader>ha",
          function() require("harpoon"):list():add() end,
          desc = "Harpoon Add File",
        },
        {
          "<leader>hX",
          function() require("harpoon"):list():clear() end,
          desc = "Harpoon Clear List",
        },
        --
        -- Toggle previous & next buffers stored within Harpoon list
        --
        {
          "<leader>hb",
          function() require("harpoon"):list():prev() end,
          desc = "Harpoon Previous Buffer",
        },
        {
          "<leader>hm",
          function() require("harpoon"):list():next() end,
          desc = "Harpoon Next Buffer",
        },
      }

      -- local select_key_names = { "h", "H", "t", "T", "n", "N", "s", "S" }
      -- local select_key_names = { "h", "t", "n", "s" }
      -- for i = 1, #select_key_names do
      --   table.insert(keys_, {
      --     "<leader>h" .. select_key_names[i],
      --     function() require("harpoon"):list():select(select_key_names[i]) end,
      --     desc = "Harpoon to File " .. select_key_names[i],
      --   })
      -- end
      for i = 1, 9 do
        table.insert(keys_, {
          "<leader>h" .. i,
          function() require("harpoon"):list():select(i) end,
          desc = "Harpoon to File " .. i,
        })
      end

      return keys_
    end,
  },
}
