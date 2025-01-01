return {
  {
    "ibhagwan/fzf-lua",
    opts = {}, -- Use default options
    keys = {
      {
        "<leader>fk", -- Bind this to your preferred key combination
        function()
          require("fzf-lua").keymaps({
            prompt = "Keymaps> ",
            modes = { "n", "i", "v", "x", "c" }, -- Include all relevant modes
          })
        end,
        desc = "Search Key Mappings",
      },
    },
  },
}
