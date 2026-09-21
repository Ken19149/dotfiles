return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Formatters
		"stevearc/conform.nvim",

		-- Package manager for LSP/tools
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Modern, Rust-powered completion engine
		{
			"saghen/blink.cmp",
			version = "1.*", -- Pin to v1 to avoid breaking changes in v2 branch
			opts = {
				keymap = {
					preset = "default",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-y>"] = { "select_and_accept" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<C-n>"] = { "select_next", "fallback" },
				},
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					per_filetype = {
						markdown = { "snippets", "buffer", "path" },
					},
				},
			},
		},

		-- Optional snippet engine (Blink has built-in support, but luasnip enables custom snippets)
		"L3MON4D3/LuaSnip",

		-- LSP status notifier
		"j-hui/fidget.nvim",
	},

	config = function()
		-- 1. Format on save configuration
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		require("fidget").setup({})
		require("mason").setup()

		-- 2. Blink capabilities for LSP
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 3. Mason LSP setup & handlers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
				"pyright",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
			},
			handlers = {
				-- Default handler: auto-attaches capabilities to any server installed via Mason
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Custom configuration for Lua
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,

				-- Custom configuration for TailwindCSS
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
					})
				end,
			},
		})

		-- 4. Floating diagnostic style
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
