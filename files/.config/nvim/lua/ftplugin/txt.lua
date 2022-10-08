-- Disable runtime ftplugin
vim.b.did_ftplugin = 1

-- Setup completion engine
require('plugs.configs.autocmp').setup_for_prose()
