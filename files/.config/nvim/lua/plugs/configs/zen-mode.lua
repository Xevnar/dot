local M = {}

function M.setup()
	require("zen-mode").setup {
		window = {
			backdrop = 1,
			width = 120,
			height = 0.9,
			options = {
			  signcolumn = "no",      -- disable signcolumn
			  number = false,         -- disable number column
			  relativenumber = false, -- disable relative numbers
			},
		},

		on_open = function(win)
			vim.cmd([[Limelight 0.8]])
		end,

		on_close = function()
			vim.cmd([[Limelight!]])
		end,
	}
end

return M
