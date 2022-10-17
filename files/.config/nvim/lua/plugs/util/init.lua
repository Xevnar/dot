local M = {}

M.path = require('plugs.util.path')

-- Loop over dirname's parents until we reach project root, if no marker was found,
-- return nil
function M.find_root(markers, bufname)
	bufname = bufname or vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	markers = vim.tbl_flatten(markers)

	local dirname = vim.fn.fnamemodify(bufname, ':p:h')
	local getparent = function(p)
		return vim.fn.fnamemodify(p, ':h')
	end

	while getparent(dirname) ~= dirname do
		for _, marker in ipairs(markers) do
			for _, path in ipairs(vim.fn.glob(M.path.join(dirname, pattern), true, true)) do
				if M.path.exists(path) then
					return dirname
				end
			end
		end

		dirname = getparent(dirname)
	end
end

return M
