return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Add f-string toggle keymap for Python
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype

        -- Ensure this is a Python file & the LSP is Ruff/Basedpyright
        if ft == "python" and client and (client.name == "ruff" or client.name == "basedpyright") then
          vim.keymap.set("n", "<leader>ctf", function()
            local line = vim.api.nvim_get_current_line()
            local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1

            -- Improved regex to handle any position in the line
            local start_pos, prefix, quote, remainder = line:match("()([rubf])[\"'](.*)")
            if not start_pos or not quote then return end -- No valid string detected

            -- Ensure remainder is a valid string
            remainder = remainder or ""

            -- Convert prefix to a table for easy manipulation
            local prefix_table = {}
            for c in prefix:gmatch(".") do
              prefix_table[c] = true
            end

            if prefix_table["f"] then
              -- Remove 'f' while keeping other prefixes intact
              prefix_table["f"] = nil
            else
              -- Add 'f' to the prefix
              prefix_table["f"] = true
            end

            -- Reconstruct the prefix, keeping the correct order
            local new_prefix = ""
            for _, c in ipairs({ "r", "u", "b", "f" }) do
              if prefix_table[c] then new_prefix = new_prefix .. c end
            end

            -- Construct the modified line without shifting other text
            local modified_line = line:sub(1, start_pos - 1) .. new_prefix .. quote .. remainder
            vim.api.nvim_set_current_line(modified_line)
          end, { buffer = bufnr, desc = "Toggle f-string" })
        end
      end,
    })

    return opts
  end,
}
