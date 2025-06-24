return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = opts.sections or {}

    -- Custom function to determine filename display
    local function custom_filename()
      local bufnr = vim.api.nvim_get_current_buf()
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local filename = vim.fn.fnamemodify(bufname, ":t") -- Get filename only
      local all_buffers = vim.api.nvim_list_bufs()

      -- Check if another buffer has the same filename
      local duplicate = false
      for _, b in ipairs(all_buffers) do
        if b ~= bufnr and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t") == filename then
          duplicate = true
          break
        end
      end

      -- If duplicate filenames exist, show relative path
      if duplicate then
        return vim.fn.fnamemodify(bufname, ":~:.") -- Show relative path
      else
        return filename -- Show just the filename
      end
    end

    -- Replace filename display in Lualine
    opts.sections.lualine_c = { custom_filename }

    return opts
  end,
}
