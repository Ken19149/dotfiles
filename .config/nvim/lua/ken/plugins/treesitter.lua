return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"jsdoc",
				"bash",
				"go",
				"python",
				"java",
				"markdown",
				"markdown_inline",
				"templ",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang or lang == "html" then
						return
					end

					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify("File larger than 100KB, treesitter disabled for performance", vim.log.levels.WARN)
						return
					end

					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}
