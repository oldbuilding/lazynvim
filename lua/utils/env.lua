local M = {}

M.get_brew_bin = function()
  local brew_bin = os.getenv("brewbin") or "/home/linuxbrew/.linuxbrew/bin/"
  if brew_bin == nil or brew_bin == "" then brew_bin = "/home/linuxbrew/.linuxbrew/opt" end
  -- vim.api.nvim_echo({ { "BREW BIN -> " .. brew_bin, "ErrorMsg" }, }, true, {})
  return brew_bin
end

M.get_brew_opt = function()
  local brew_opt = os.getenv("brewopt") or "/home/linuxbrew/.linuxbrew/opt"
  if brew_opt == nil or brew_opt == "" then brew_opt = "/home/linuxbrew/.linuxbrew/opt" end
  -- vim.api.nvim_echo({ { "BREW OPT -> " .. brew_opt, "DEBUG" } }, false, {})
  return brew_opt
end

M.get_hererocks_path = function()
  local hererocks_path = os.getenv("HOME") .. "/.local/pipx/venvs/hererocks"
  -- vim.api.nvim_echo({ { "HEREROCKS -> " .. hererocks_path, "DEBUG" } }, false, {})
  return hererocks_path
end

M.get_python3_host_prog = function()
  local python3_host_prog = os.getenv("NEOVIM_PYTHON3_VENV_PATH") or vim.fn.expand("~/.local/venvs/nvim/bin/python3")
  vim.g.python3_host_prog = python3_host_prog
  return python3_host_prog
end

M.setup = function()
  local brew_opt_path = M.get_brew_opt()
  local brew_bin_path = M.get_brew_bin()

  vim.env.BREW_OPT_PATH = brew_opt_path
  vim.env.BREW_BIN_PATH = brew_bin_path

  local hererocks_path = M.get_hererocks_path()

  vim.env.HEREROCKS_PATH = hererocks_path

  package.path = package.path .. ";" .. hererocks_path .. "/share/lua/5.1/?.lua;" .. hererocks_path .. "/share/lua/5.1/?/init.lua;"
  -- vim.api.nvim_echo({ { "package.path -> " .. package.path, "DEBUG" } }, false, {})

  package.cpath = package.cpath .. ";" .. hererocks_path .. "/lib/lua/5.1/?.so;"
  -- vim.api.nvim_echo({ { "package.cpath -> " .. package.cpath, "DEBUG" } }, false, {})

  vim.env.GIT_EXEC_PATH = brew_opt_path .. "/git/libexec/git-core"
  -- vim.api.nvim_echo({ { "GIT_EXEC_PATH -> " .. vim.env.GIT_EXEC_PATH, "DEBUG" } }, false, {})

  vim.env.LUA_PATH = hererocks_path .. "/share/lua/5.1/?.lua;" .. hererocks_path .. "/share/lua/5.1/?/init.lua;;"
  -- vim.api.nvim_echo({ { "LUA_PATH -> " .. vim.env.LUA_PATH, "DEBUG" } }, false, {})

  vim.env.LUA_CPATH = hererocks_path .. "/lib/lua/5.1/?.so;;"
  -- vim.api.nvim_echo({ { "LUA_CPATH -> " .. vim.env.LUA_CPATH, "DEBUG" } }, false, {})

  vim.env.PATH = hererocks_path .. "/bin:" .. vim.env.PATH

  M.get_python3_host_prog()
end

return M
