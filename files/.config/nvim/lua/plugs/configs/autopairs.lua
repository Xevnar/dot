local M = {}

function M.setup()
	-- Prevent AutoPairs from remapping space
	vim.g.AutoPairsMapSpace = 0
	-- Avoid jumping to a closing pair in a new line
	vim.g.AutoPairsMultilineClose = 0
end

return M
