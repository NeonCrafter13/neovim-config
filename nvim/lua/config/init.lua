--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: config/init.lua
-- Description: Main configurations
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

local modules = {"config.autocmds", "config.options", "config.keymaps"}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end

require("lazy").setup({
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    spec = {{{
        import = "plugins"
    }, {
        import = "plugins.custom"
    }}},
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        version = nil
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    install = {
        -- install missing plugins on startup
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = {"rose-pine", "blue"}
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true
    }
})