local util = require('plugs.util')

-- Launch language server
require('lspconfig').omnisharp.setup {
	-- The command that starts the language server
	cmd = {
		'omnisharp', '-z',
		'--languageserver' ,
		'--hostPID', tostring(vim.fn.getpid()),
		'--encoding', 'utf-8',
		'DotNet:enablePackageRestore=false',
	},

	-- Extended textDocument/definition handler that handles assembly/decompilation
	-- loading for $metadata$ documents.
	handlers = {
		["textDocument/definition"] = require('omnisharp_extended').handler,
	},

	-- Setup completion engine
	capabilities = require('plugs.configs.autocmp').setup_for_source(),

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,

	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = function(fname)
		return require('plugs.util').find_root({
			-- Zero-module projects
			{ '.git', 'src', 'code', 'Code', },
			-- Single-module projects, I'm not familiar with C# project structure
			{ '*.csproj', '*.sln', },
		})
	end,

	on_new_config = function(new_config, new_root_dir)
		vim.list_extend(new_config.cmd, { '-s', new_root_dir })

		if new_config.enable_editorconfig_support then
			table.insert(new_config.cmd, 'FormattingOptions:EnableEditorConfigSupport=true')
		end

		if new_config.organize_imports_on_format then
			table.insert(new_config.cmd, 'FormattingOptions:OrganizeImports=true')
		end

		if new_config.enable_ms_build_load_projects_on_demand then
			table.insert(new_config.cmd, 'MsBuild:LoadProjectsOnDemand=true')
		end

		if new_config.enable_roslyn_analyzers then
			table.insert(new_config.cmd, 'RoslynExtensionsOptions:EnableAnalyzersSupport=true')
		end

		if new_config.enable_import_completion then
			table.insert(new_config.cmd, 'RoslynExtensionsOptions:EnableImportCompletion=true')
		end

		if new_config.sdk_include_prereleases then
			table.insert(new_config.cmd, 'Sdk:IncludePrereleases=true')
		end

		if new_config.analyze_open_documents_only then
			table.insert(new_config.cmd, 'RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true')
		end
	end,

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common(bufnr)
	end,
}

-- Launch language server
require('lspconfig').omnisharp.manager.try_add_wrapper()
