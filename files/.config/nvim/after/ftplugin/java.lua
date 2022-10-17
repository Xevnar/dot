-- Dynamacially build available java runtimes
local function get_runtimes()
	local runtimes = {}

	-- The following envs have been taken from: https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	 local jdk_envs = {
		 _5 = 'J2SE-1.5',   _6 = 'JavaSE-1.6', _7 = 'JavaSE-1.7', _8 = 'JavaSE-1.8', _9 = 'JavaSE-9',
		_11 = 'JavaSE-11', _10 = 'JavaSE-10', _12 = 'JavaSE-12', _13 = 'JavaSE-13', _14 = 'JavaSE-14',
		_15 = 'JavaSE-15', _16 = 'JavaSE-16', _17 = 'JavaSE-17', _18 = 'JavaSE-18',
	 }

	-- Loop over JDKs in the jvm directory. if multiple JDKs exist for the same
	-- java version, the first JDK is used
	local jdk_path = '/usr/lib/jvm'
	local available_jdks = vim.fn.globpath(jdk_path, 'java-*-*', false, true)
	logger.trace('Available JDKs: ' .. vim.inspect(available_jdks))
	for _, jdk in ipairs(available_jdks) do
		local jdk_ver = jdk:match('%d+')
		if runtimes[jdk_ver] then
			goto continue
		end

		local runtime = {}
		runtime.name = jdk_envs['_' .. jdk_ver]
		runtime.path = jdk

		-- Check if the JDK's source file exists or not
		local src_file = jdk .. '/src.zip'
		if vim.fn.filereadable(src_file) == 1 then
			runtime.sources = src_file
		end

		local jdk_doc_path = '/usr/share/doc'
		local docs_path = jdk_doc_path .. '/java' .. jdk_ver .. '-openjdk/api'
		if vim.fn.isdirectory(docs_path) == 1 then
			runtime.javadoc = docs_path
		end

		-- Check if this jdk is the default jdk
		local default_jdk = jdk_path .. '/default'
		if vim.fn.isdirectory(default_jdk) == 1 and vim.fn.resolve(default_jdk) == jdk then
			runtime.default = true
		end

		runtimes[jdk_ver] = runtime
		::continue::
	end

	logger.trace('Java runtimes: ' .. vim.inspect(runtimes))
	return runtimes
end

local config = {
	-- The command that starts the language server
	-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
	cmd = { 'java-lsp', vim.env.XDG_DATA_HOME .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'), },

	-- I don't know where this came from. There is no mention of it in the nvim-jdtls docuentation
	flags = {
		allow_incremental_sync = true,
	},

	-- Setup completion engine
	capabilities = require('plugs.configs.autocmp').setup_for_source(),

	-- Modify lsp settings, more can be found below:
	-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			signatureHelp = { enabled = true },
			configuration = {
				runtimes = get_runtimes(),
			},
		},
	},

	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require('plugs.util').find_root({
		-- Zero-module projects
		{ '.git', 'src', 'code', 'Code', },
		-- Single-module projects
		{
			'build.xml', -- Ant
			'pom.xml', -- Maven
			'settings.gradle', -- Gradle
			'settings.gradle.kts', -- Gradle
		},
		-- Multi-module projects
		{ 'build.gradle', 'build.gradle.kts', },
	}),

	on_init = function(client, _)
		client.notify('workspace/didChangeConfiguration', { settings = config.settings })
	end,

	-- Define on_attach first since it doesn't work if defined below for some reason
	on_attach = function(client, bufnr)
		require('jdtls.setup').add_commands()
		require('keybindings.lsp').jdtls(bufnr)
	end,
}

-- Launch language server
require('jdtls').start_or_attach(config)
