local M = {}

-- Options to be used with `vim.keymap.set`
M.opts = {
	none = { }, -- Behaves the same as `opts.noremap` since the default is 'remap = false'
	remap = { remap = true, },
	noremap = { remap = false, },
	silent = { silent = true, remap = true, },
	both = { silent = true, remap = false, },
}

-- The function is called `t` for `termcodes`.
function M.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
