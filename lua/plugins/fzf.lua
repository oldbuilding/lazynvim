return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        winblend = 0, -- Make popups opaque
        row = 0.5, -- 0 top, 1 bottom
        col = 0.5, -- 0 top, 1 bottom
        border = "rounded",
        -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
        backdrop = 60,
        preview = {
          border = "rounded",
          wrap = true,
        },
      },
    },
    keys = {
      {
        "<leader>so",
        function()
          -- Retrieve all options and their values
          local options = vim.api.nvim_get_all_options_info()
          local results = {}

          for name, _ in pairs(options) do
            local success, value = pcall(vim.api.nvim_get_option, name)
            if success then
              table.insert(results, string.format("%-20s -> %s", name, vim.inspect(value)))
            else
              table.insert(results, string.format("%-20s -> [unreadable]", name))
            end
          end

          -- If no results, show a message
          if #results == 0 then
            vim.notify("No options found", vim.log.levels.WARN)
            return
          end

          -- Pass options to fzf-lua with a custom horizontal preview and title
          require("fzf-lua").fzf_exec(results, {
            prompt = "Vim Options> ",
            previewer = {
              -- Custom preview function for wrapped content
              fn = function(entry)
                local line = entry or ""
                local option_name = line:match("^(%S+)")
                if not option_name then return "Invalid selection" end

                local success, value = pcall(vim.api.nvim_get_option, option_name)
                if success then
                  local wrapped_value = vim.inspect(value):gsub("(%S[%S ]-)", function(chunk) return (#chunk > 80 and chunk .. "\n" or chunk) end)
                  return string.format("Option: %s\nValue:\n%s", option_name, wrapped_value)
                else
                  return string.format("Error getting option: %s", option_name)
                end
              end,
            },
            -- Adjust layout for horizontal preview and dynamic title
            winopts = {
              preview = {
                horizontal = "up:23%", -- Open preview horizontally at the top
                title = function(entry)
                  -- Extract only the option name for the title
                  local option_name = entry and entry:match("^(%S+)")
                  if option_name then
                    return option_name
                  else
                    return "Preview"
                  end
                end,
                hidden = true, -- Ensure the content is not treated as a file path
              },
            },
            actions = {
              ["default"] = function(selected)
                if selected and #selected > 0 then vim.notify("Selected: " .. selected[1], vim.log.levels.INFO) end
              end,
            },
          })
        end,
        desc = "Search Vim Options",
      },
    },
  },
}

--   "<leader>fk", -- Bind this to your preferred key combination
--   function()
--     require("fzf-lua").keymaps({
--       prompt = "Keymaps> ",
--       modes = { "n", "i", "v", "x", "c" }, -- Include all relevant modes
--     })
--   end,
--   desc = "Search Key Mappings",
-- },
