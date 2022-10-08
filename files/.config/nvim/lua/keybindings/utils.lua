local M = {}

-- The function is called `t` for `termcodes`.
function M.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Wrappers
function M.buf_set_keymap(...)
	vim.api.nvim_buf_set_keymap(bufnr, ...)
end

function M.buf_set_option(...)
	vim.api.nvim_buf_set_option(bufnr, ...)
end

return M
