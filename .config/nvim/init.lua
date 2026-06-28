-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core settings (before plugins, so leader is set)
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load plugins
require("lazy").setup("plugins", {
  checker = { enabled = false }, -- don't auto-check for updates
  change_detection = { notify = false }, -- don't spam on config change
})
