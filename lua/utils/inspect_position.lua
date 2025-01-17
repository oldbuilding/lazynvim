if true then return {} end

local M = {}

M.show_hover = function(data, comment)
  local content = {} -- Collect lines for the buffer

  -- Utility to split multiline strings
  local function split_multiline_string(str)
    local lines = {}
    for line in tostring(str):gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end
    return lines
  end

  -- Add hl_group to content
  table.insert(content, "  - " .. tostring(data.hl_group))
  if data.hl_group then vim.list_extend(content, split_multiline_string(data.hl_group)) end

  -- Add link information to content
  if data.hl_group_link and data.hl_group ~= data.hl_group_link then table.insert(content, "links to " .. tostring(data.hl_group_link) .. "   ") end

  -- Add comment if present
  if comment then vim.list_extend(content, split_multiline_string(comment)) end

  -- Handle empty content gracefully
  if #content == 0 then table.insert(content, "No content to display") end

  -- Create the hover window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown") -- Optional for syntax highlighting
  vim.api.nvim_buf_set_option(buf, "wrap", true) -- Enable text wrapping

  -- Determine window size
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#content + 2, vim.o.lines - 4)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Set keybinding to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bd!<CR>", { noremap = true, silent = true })

  -- Optional: Add additional styling
  vim.api.nvim_buf_set_option(buf, "winblend", 0) -- OPAQUE
end

return M
