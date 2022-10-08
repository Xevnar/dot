local M = {}

function M.setup()
	-- Colour display method
	vim.g.Hexokinase_highlighters = { 'virtual' }
	-- Set types to be highlighted by hexokinase
	vim.g.Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla'
end

return M
