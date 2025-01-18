local M = {}

vim.keymap.set({ "n" }, "<leader>ci", "<Cmd>ConformInfo<CR>", { desc = "ConformInfo", silent = true, noremap = true })

---------------------------------------------------------------------------------------------------------------------------
---
-- 1) A small helper to apply code actions synchronously:
--    This requests code actions for the given "only" param, then applies them.
local function apply_code_actions_sync(only_kinds, timeout_ms)
  -- Create LSP params for the entire buffer range
  local params = vim.lsp.util.make_range_params()
  params.context = { only = only_kinds }

  -- Request code actions synchronously
  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms or 3000)
  if not results then return end

  -- Each LSP client can return a list of possible code actions
  for client_id, res in pairs(results) do
    if res.result and #res.result > 0 then
      for _, action in ipairs(res.result) do
        -- If the action has `edit` or a `command`, apply it
        local client = vim.lsp.get_client_by_id(client_id)
        local enc = client and client.offset_encoding or "utf-16"
        if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, enc) end
        if action.command then vim.lsp.buf.execute_command(action.command) end
      end
    end
  end
end

-- 2) Our main function for Python-only multi-step:
--    - Ruff fixAll
--    - Ruff organizeImports
--    - Format
--    - Save
M.python_ruff_actions_and_save = function()
  -- a) Check filetype
  if vim.bo.filetype ~= "python" then
    vim.cmd("write")
    return
  end

  -- b) Run ruff fixAll code action
  --    Often registered as "source.fixAll.ruff" or just "source.fixAll"
  apply_code_actions_sync({ "source.fixAll.ruff" })

  -- c) Run ruff organizeImports code action
  apply_code_actions_sync({ "source.organizeImports.ruff" })

  -- d) Format (synchronous)
  vim.lsp.buf.format({ async = false })

  -- e) Finally, save
  vim.cmd("write")
end

return M
---------------------------------------------------------------------------------------------------------------------------

-- local function format_and_save_current()
--   -- Synchronous formatting (blocks until done):
--   vim.lsp.buf.format({
--     async = false,
--     filter = function(client)
--       -- Optionally choose which client(s) to do the formatting
--       return client.name ~= "some_other_language_server"
--     end,
--   })
--   vim.cmd("write")
-- end
--
-- vim.keymap.set("n", "<leader>fs", format_and_save_current, { desc = "Format & Save buffer" })
