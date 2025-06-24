return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        local reveal_file_ = vim.fn.expand("%:p")
        if reveal_file_ == "" then
          reveal_file_ = vim.fn.getcwd()
        else
          local f = io.open(reveal_file_, "r")
          if f then
            f.close(f)
          else
            reveal_file_ = vim.fn.getcwd()
          end
        end
        require("neo-tree.command").execute({
          toggle = false,
          focus = true,
          reveal_file = reveal_file_,
          dir = LazyVim.root(),
        })
      end,
      desc = "Explorer NeoTree (current file or cwd)",
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({
          toggle = false,
          focus = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "Explorer NeoTree (cwd)",
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({
            toggle = false,
            focus = true,
            dir = vim.uv.cwd(),
          })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    {
      "<leader>ge",
      function() require("neo-tree.command").execute({ source = "git_status", toggle = true, focus = true }) end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function() require("neo-tree.command").execute({ source = "buffers", toggle = true, focus = true }) end,
      desc = "Buffer Explorer",
    },
  },
  opts = {
    window = {
      position = "left",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_by_name = {
          "bin",
          "obj",
          "node_modules",
          "__pycache__",
          "'~'",
        },
        always_show_by_pattern = { -- uses glob style patterns
          ".env*",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = { -- uses glob style patterns
          ".null-ls_*",
        },
      },
    },
  },
}
