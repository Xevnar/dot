-- Set by goyo_pre_leave & used by goyo_leave to open the wiki file
-- in the buffer after leaving goyo
local last_open_file = ''

function goyo_enter()
	vim.opt.showmode = false
	vim.opt.showcmd = false
	vim.cmd([[Limelight!]])
end

function goyo_pre_leave()
	last_open_file = vim.fn.expand('%:p')
end

function goyo_leave()
	-- Restore changed settings when exiting goyo
	vim.opt.showmode = true
	vim.opt.showcmd = true
	vim.cmd([[Limelight!]])

	last_open_file = vim.cmd([[get(s:, 'open_file', bufname())]])
	if last_open_file == '' then
		return
	end

	local vimwiki_index = vim.cmd([[getbufvar('%', 'vimwiki_wiki_nr', -1)]])
	if vimwiki_index < 0 or vimwiki_index >= #vim.g.vimwiki_list then -- Not in a vimwiki
		vim.cmd("execute 'edit " .. last_open_file .. "'")
		return
	end

	-- Check if open file is in the current wiki or not
	local vimwiki_path = vim.g.vimwiki_list[vimwiki_index].path

	-- Remove prefix so that path is relative to vim wiki
	local relative_path = vim.fn.substitute(last_open_file, vimwiki_path .. '/', '', '')

	-- if not in wiki; then change path so that it is relavent to wiki, by
	-- adding as many '../' as necessary
	--if relative_path ~= last_open_file then
		-- TODO: figure this shit out
	--end

	-- Go to file through 'VimwikiGoto $link' so that we can backtrack
	-- through the link
	vim.cmd("execute 'VimwikiGoto " .. relative_path .. "'")
end

local M = {}

function M.setup()
	-- Define autogroup for goyo autocommands
	local au_group_id = vim.api.nvim_create_augroup('goyo', {
	    clear = false
	})

	-- Setup goyo callbacks
	vim.api.nvim_create_autocmd("User", {
		group = au_group_id,
		pattern = 'GoyoEnter',
		callback = goyo_enter,
		nested = true,
	})

	vim.api.nvim_create_autocmd("User", {
		group = au_group_id,
		pattern = 'GoyoPreLeave',
		callback = goyo_pre_leave,
		nested = true,
	})

	vim.api.nvim_create_autocmd("User", {
		group = au_group_id,
		pattern = 'GoyoLeave',
		callback = goyo_leave,
		nested = true,
	})
end

return M
