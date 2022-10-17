local M = {}

function M.setup()
	require'nvim-treesitter.configs'.setup {
		ensure_installed = {
			'lua', 'vim', 'bash', 'python', 'javascript', 'typescript', 'php', 'r',
			'c', 'go', 'rust', 'java', 'kotlin', 'c_sharp',
			'toml', 'query', 'markdown', 'html', 'css',
			'comment', 'regex'
		},

		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		highlight = {
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		playground = {
			enable = true,
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = 'o',
				toggle_hl_groups = 'i',
				toggle_injected_languages = 't',
				toggle_anonymous_nodes = 'a',
				toggle_language_display = 'I',
				focus_language = 'f',
				unfocus_language = 'F',
				update = 'R',
				goto_node = '<cr>',
				show_help = '?',
			},
		},
	}
end

return M
