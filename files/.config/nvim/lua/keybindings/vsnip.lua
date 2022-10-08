local t = require('keybindings.utils').t

local M = {}

function M.setup()
	-- Define vsnip function wrappers
	function _G.vsnip_jumpable(direction, jump, default)
		return vim.fn['vsnip#jumpable'](direction) and jump or default
	end

	function _G.vsnip_expandable(jump, default)
		return vim.fn['vsnip#expandable']() and jump or default
	end

	function _G.vsnip_avialable(jump, default)
		return vim.fn['vsnip#available'](1) and jump or default
	end

	-- Vsnip  keybinds
	local keybind = vim.api.nvim_set_keymap
	local opts = { expr = true, }
	keybind('i', t'<S-Tab>', t[[v:lua.vsnip_jumpable(-1, '<Plug>(vsnip-jump-prev)', '<S-Tab>')]], opts)
	keybind('s', t'<S-Tab>', t[[v:lua.vsnip_jumpable(-1, '<Plug>(vsnip-jump-prev)', '<S-Tab>')]], opts)

	keybind('i', t'<Tab>', t[[v:lua.vsnip_jumpable(1, '<Plug>(vsnip-jump-next)', '<Tab>')]], opts)
	keybind('s', t'<Tab>', t[[v:lua.vsnip_jumpable(1, '<Plug>(vsnip-jump-next)', '<Tab>')]], opts)

	keybind('i', t'<C-j>', t[[v:lua.vsnip_expandable('<Plug>(vsnip-expand)', '<C-j>')]], opts)
	keybind('s', t'<C-j>', t[[v:lua.vsnip_expandable('<Plug>(vsnip-expand)', '<C-j>')]], opts)

	keybind('i', t'<C-l>', t[[v:lua.vsnip_available('<Plug>(vsnip-expand-or-jump)', '<C-l>')]], opts)
	keybind('s', t'<C-l>', t[[v:lua.vsnip_available('<Plug>(vsnip-expand-or-jump)', '<C-l>')]], opts)
end

return M
