local M = {}

function M.setup_for_source()
	return M.setup {
		insert = {
			{ name = 'vsnip' },
			{ name = 'buffer', keyword_length = 5 },
			{ name = 'nvim_lsp' },
		},

		setup_dict = false,
	}
end

function M.setup_for_prose()
	return M.setup {
		insert = {
			{ name = 'buffer', keyword_length = 5 },
			{ name = 'dictionary', keyword_length = 2 },
			{ name = 'latex_symbols' },
		},

		setup_dict = true,
		always_insert_space = true,
	}
end

function M.setup(args)
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	local cmp = require'cmp'

	-- Only setup cmp for the current buffer
	cmp.setup.buffer({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert({
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<SPACE>'] = function(original_mapping)
				if cmp.visible() and cmp.get_active_entry() ~= nil  then
					local get_callback = function(mapping, always_insert_space)
						if always_insert_space then
							return mapping
						end

						-- Conditionally add space char depending on what's inserted
						local entry = cmp.get_active_entry()
						logger.trace('Entry Name: ' .. entry.source.name)

						-- Never insert a space if the source was a snippet
						if entry.source.name == 'vsnip' then
							return nil
						end

						-- If source was the lsp, only insert a space if it was not a snippet
						if entry.source.name == 'nvim_lsp' then
							local view = entry:get_view(0, vim.api.nvim_get_current_buf())
							logger.trace('Entry View: ' .. vim.inspect(view))

							if view.kind.text ~= 'Snippet' then
								return mapping
							end
						end
					end

					cmp.confirm ({
						-- Insert selection instead of replacing current text
						behavior = cmp.ConfirmBehavior.Replace,

						-- Don't select the first item if nothing is selected
						select = false,
					}, get_callback(original_mapping, args.always_insert_space))
				else
					-- Most likely just insert space after confirming
					original_mapping()
				end
			end,
		}),

		-- DO NOT PRESELECT ANYTHING FOR ME
		preselect = cmp.PreselectMode.None,

		sources = cmp.config.sources(
			args.insert or {}
		),

		formatting = {
			format = require('lspkind').cmp_format {
				-- Disable the god awful default symbols
				mode = 'text',

				-- Set the name of each source
				menu = {
					path          = "[path]",
					spell         = "[spell]",
					vsnip         = "[snip]",
					buffer        = "[buff]",
					nvim_lsp      = "[LSP]",
					dictionary    = "[dict]",
					latex_symbols = "[tex]",
				},
			},
		},

		experimental = {
		  ghost_text = true,
		},
	})

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),

		sources = {
			args.search or {
				name = 'buffer', keyword_length = 3
			}
		}
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),

		sources = cmp.config.sources(
			args.cmd or {
				{ name = 'path' },
				{ name = 'cmdline' }
			}
		)
	})

	if args.setup_dict then
		require("cmp_dictionary").setup({
			dic = {
				["*"] = { "/usr/share/dict/words" },
			},

			-- It decides how many characters at the beginning are used as the exact
			-- match. If -1, only candidates with an exact prefix match will be returns.
			exact = 2,

			-- If true, it will ignore the case of the first character. For example,
			-- if you have "Example" and "excuse" in your dictionary, typing "Ex"
			-- will bring up "Example" and "Excuse" as candidates, while typing
			-- "ex" will bring up "example" and "excuse".
			first_case_insensitive = false,

			-- If true, perform the initialization in a separate thread. If you are
			-- using a very large dictionary and the body operation is blocked, try this.
			async = false,

			-- Determines the maximum number of dictionaries to be cached. This will prevent
			-- duplicate reads when you switch dictionaries with the settings described above.
			capacity = 5,

			-- If true, debug messages are output.
			debug = false,
		})
	end

	return require('cmp_nvim_lsp').default_capabilities()
end

return M
