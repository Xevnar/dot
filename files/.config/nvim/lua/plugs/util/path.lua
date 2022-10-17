local M = {}

local is_windows = vim.loop.os_uname().version:match('Windows')

M.sep = is_windows and '\\' or '/'

function M.join(...)
	local result = table.concat(vim.tbl_flatten {...}, M.sep):gsub(M.sep .. '+', M.sep)
	return result
end


function M.escape_wildcards(path)
	return path:gsub('([%[%]%?%*])', '\\%1')
end

function M.sanitize(path)
	if is_windows then
		path = path:sub(1, 1):upper() .. path:sub(2)
		path = path:gsub('\\', '/')
	end
	return path
end


function M.exists(filename)
	local stat = vim.loop.fs_stat(filename)
	return stat and stat.type or false
end


function M.is_dir(filename)
	return exists(filename) == 'directory'
end

function M.is_file(filename)
	return exists(filename) == 'file'
end

function M.is_fs_root(path)
	if is_windows then
		return path:match '^%a:$'
	else
		return path == '/'
	end
end

function M.is_absolute(filename)
	if is_windows then
		return filename:match '^%a:' or filename:match '^\\\\'
	else
		return filename:match '^/'
	end
end

function M.dirname(path)
	local strip_dir_pat = '/([^/]+)$'
	local strip_sep_pat = '/$'
	if not path or #path == 0 then
		return
	end
	local result = path:gsub(strip_sep_pat, ''):gsub(strip_dir_pat, '')
	if #result == 0 then
		if is_windows then
			return path:sub(1, 2):upper()
		else
			return '/'
		end
	end
	return result
end


-- Traverse the path calling callback along the way.
function M.traverse_parents(path, callback)
	path = vim.loop.fs_realpath(path)
	local dir = path
	-- Just in case our algo is buggy, don't infinite loop.
	for _ = 1, 100 do
		dir = M.dirname(dir)
		if not dir then
			return
		end
		-- If we can't ascend further, then stop looking.
		if callback(dir, path) then
			return dir, path
		end

		if M.is_fs_root(dir) then
			break
		end
	end
end

-- Iterate the path until we find the rootdir.
function M.iterate_parents(path)
	local function it(_, v)
		if v and not M.is_fs_root(v) then
			v = dirname(v)
		else
			return
		end
		if v and vim.loop.fs_realpath(v) then
			return v, path
		else
			return
		end
	end
	return it, path, path
end

function M.is_descendant(root, path)
	if not path then
		return false
	end

	local function callback(dir, _)
		return dir == root
	end

	local dir, _ = M.traverse_parents(path, callback)

	return dir == root
end

return M
