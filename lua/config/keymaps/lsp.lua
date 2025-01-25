local M = {}

---------------------------------------------------------------------------------------------------------------------------
---
local function apply_code_actions_sync(only_kinds, timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = only_kinds }

  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms or 3000)
  if not results then return end

  for client_id, res in pairs(results) do
    if res.result and #res.result > 0 then
      for _, action in ipairs(res.result) do
        local client = vim.lsp.get_client_by_id(client_id)
        local enc = client and client.offset_encoding or "utf-16" -- Default to utf-16
        if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, enc) end
        if action.command then vim.lsp.buf.execute_command(action.command) end
      end
    end
  end
end

M.python_ruff_actions_and_save = function()
  -- Check filetype
  if vim.bo.filetype ~= "python" then
    vim.cmd("write")
    return
  end

  -- Run ruff fixAll code action
  --    Often registered as "source.fixAll.ruff" or just "source.fixAll"
  apply_code_actions_sync({ "source.fixAll.ruff" })

  -- Format (synchronous)
  vim.lsp.buf.format({ async = false })

  -- apply_code_actions_sync({ "quickfix" })

  -- Finally, save
  vim.cmd("write")
end
---------------------------------------------------------------------------------------------------------------------------

vim.keymap.set({ "n" }, "<leader>ci", "<Cmd>ConformInfo<CR>", { desc = "ConformInfo", silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>cc", function() M.python_ruff_actions_and_save() end, { desc = "Ruff Fixes", silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>cr", "<Cmd>LspRestart basedpyright ruff<CR>", { desc = "Lsp Restart *", silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>ch", vim.lsp.buf.hover, { desc = "Hover Documentation", silent = true, noremap = true })

-- vim.keymap.set("n", "<leader>c-", function()
--   local params = vim.lsp.util.make_position_params()
--   params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
--
--   vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result)
--     if err or not result then
--       vim.notify("No code actions available", vim.log.levels.WARN)
--       return
--     end
--
--     for i, action in ipairs(result) do
--       print(string.format("[%d] %s (%s)", i, action.title, action.kind or "no kind"))
--     end
--   end)
-- end, { desc = "Log available code actions" })
--
-- local function log_code_actions()
--   local params = vim.lsp.util.make_range_params()
--   params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
--
--   vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result)
--     if err then
--       vim.notify("Error fetching code actions: " .. err.message, vim.log.levels.ERROR)
--       return
--     end
--     if result then
--       for i, action in ipairs(result) do
--         print(string.format("[%d] %s (%s)", i, action.title, action.kind or "no kind"))
--       end
--     else
--       vim.notify("No code actions available", vim.log.levels.INFO)
--     end
--   end)
-- end
--
-- vim.keymap.set("n", "<leader>cg", log_code_actions, { desc = "Log available code actions" })
return M
---------------------------------------------------------------------------------------------------------------------------
