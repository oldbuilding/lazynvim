return {
  "folke/noice.nvim",
  enabled = false, -- Disabled in favor of Snacks notifier
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
      -- Route all notifications to mini view (bottom right)
      {
        filter = {
          event = "notify",
        },
        view = "mini",
      },
      -- Handle substitute commands to prevent Treesitter errors
      {
        filter = {
          event = "msg_show",
          find = "^substitute",
        },
        view = "mini",
      },
      -- Bypass Noice for command line messages to prevent execution issues
      {
        filter = {
          event = "msg_show",
          kind = "",
        },
        view = false, -- Disable Noice for these messages
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false, -- Disable command palette
      long_message_to_split = true,
      lsp_doc_border = true,
      -- Use mini view for notifications (bottom right)
      notify = "mini",
      -- Disable all cmdline features to prevent command execution issues
      cmdline_popup = false,
      cmdline_editing = false,
    },
    views = {
      popupmenu = {
        backend = "nui",
        win_options = {
          winblend = 0, -- opaque
        },
      },
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then vim.cmd([[messages clear]]) end

    -- Add error handling for Treesitter issues
    local ok, noice = pcall(require, "noice")
    if not ok then
      vim.notify("Failed to load noice: " .. tostring(noice), vim.log.levels.ERROR)
      return
    end

    -- Setup with error handling
    local setup_ok, setup_err = pcall(noice.setup, opts)
    if not setup_ok then
      vim.notify("Failed to setup noice: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end
  end,
}
