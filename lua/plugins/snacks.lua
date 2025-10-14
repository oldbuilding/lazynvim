return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local snacks = require("snacks")
    snacks.setup({
      -- Enable notifier module for notifications
      notifier = {
        enabled = true,
        -- Configure for bottom-right positioning
        position = "bottom_right",
        -- Use compact style
        style = "compact",
      },
    })

    -- Set up keybindings for notifications
    vim.keymap.set("n", "<leader>un", function()
      require("snacks.notifier").hide()
    end, { desc = "Dismiss All Notifications" })
  end,
}
