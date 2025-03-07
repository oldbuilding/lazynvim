local M = {}

function M.find_project_root()
  local Path = require("plenary.path")
  -- Function finds the nearest project root by locating the .git directory
  local cwd = vim.fn.getcwd()
  local current_path = Path:new(cwd)

  while not current_path:joinpath(".git"):exists() do
    if current_path == current_path:parent() then return nil end
    current_path = current_path:parent()
  end

  local result = current_path:absolute()
  return result
end

function M.get_editorconfig_path()
  local Path = require("plenary.path")
  local project_root = M.find_project_root()
  if project_root then
    local project_config = Path:new(project_root, ".editorconfig")
    if project_config:exists() then return project_config:absolute() end
  end
  return vim.fn.expand("~/.editorconfig")
end

function M.get_mason_bin() return vim.fn.expand("~/.local/share/" .. (os.getenv("NVIM_APPNAME") or "nvim") .. "/mason/bin") end

function M.get_brew_opt() return os.getenv("brewopt") or "" end
function M.get_brew_bin() return os.getenv("brewbin") or "" end
return M
