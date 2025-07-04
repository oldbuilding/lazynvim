local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "git@github.com:folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("utils.env").setup()
require("config.colorschemes")
require("config.buffers")

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    colorscheme = {
      "bamboo",
      "catppuccin",
      "deepwhite",
      "emerald",
      "falcon",
      "habamax",
      "kangawa",
      "melange",
      "miasma",
      "mini.base16",
      "night-owl",
      "nvim-solar-paper",
      "ofirkai",
      "oh-lucy",
      "onedark",
      "oxocarbon",
      "rose-pine",
      "starry",
      "tokyonight",
      "whitch",
      "zaibatsu",
    },
  },
  colorscheme = "tokyonight-night", -- "emerald", -- "tokyonight-day", -- "oh-lucy-evening",
  background = "dark",
  ui = {
    backdrop = 100, -- 0 opaque, 100 transparent
    border = "rounded",
    wrap = true,
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = true, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "man",
        -- "matchit",
        -- "matchparen",
        "netrw",
        "netrwFileHandlers",
        -- "netrwPlugin",
        "netrwSettings",
        "osc52",
        "rplugin",
        "rrhelper",
        "shada",
        "spec",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  pkg = {
    enabled = true,
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
    -- the first package source that is found for a plugin will be used.
    sources = {
      "lazy",
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },
  rocks = {
    enabled = true,
    root = require("utils.env").get_hererocks_path() .. "/lazy-rocks",
    -- root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
  },
})

require("config.options").setup()
