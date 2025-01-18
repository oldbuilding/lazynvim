return {
  {
    "alexpasmantier/pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    config = function()
      require("pymple").setup({
        update_imports = {
          filetypes = { "python" },
        },
        add_import_to_buf = {
          autosave = false,
        },
        keymaps = {
          resolve_import_under_cursor = {
            desc = "Resolve import under cursor",
            keys = "<leader>c>",
          },
        },
        python = {
          root_markers = { "pyproject.toml", "setup.py", ".git", "manage.py", ".venv", ".pie" },
          virtual_env_names = { ".venv", ".pie" },
        },
      })
    end,
  },
}
