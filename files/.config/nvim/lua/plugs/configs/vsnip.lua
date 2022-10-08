local M = {}

function M.setup()
	-- Set snippets directory
	vim.g.vsnip_snippet_dir = vim.env.XDG_CONFIG_HOME .. '/nvim/snippets/'

	-- Define vsnip keybinds
	require('keybindings.vsnip').setup()
end

return M
