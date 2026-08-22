return {
	"nvim-telescope/telescope.nvim", 
	dependencies = { "nvim-lua/plenary.nvim" }, 

	config = function() 
		require("telescope").setup({})
		local builtin = require('telescope.builtin')

        -- Helper function to find the root directory (compatible with Oil & standard files)
		local function get_project_root()
			local current_path = vim.api.nvim_buf_get_name(0)

			-- 1. Strip the custom Oil URI prefix if browsing inside Oil
			if current_path:match("^oil://") then
				current_path = current_path:gsub("^oil://", "")
			elseif current_path ~= "" then
				-- For regular files, get the parent directory
				current_path = vim.fs.dirname(current_path)
			else
				current_path = vim.fn.getcwd()
			end

			-- 2. Search upwards from the cleaned path for project markers
			local root = vim.fs.root(current_path, { ".git", ".stfolder", "package.json" })
			if root then
				return root
			end

			-- 3. If no project marker exists, use the cleaned directory itself
			if current_path ~= "" and vim.fn.isdirectory(current_path) == 1 then
				return current_path
			end

			return vim.fn.getcwd()
		end

		-- Wrapper for find_files
		local function find_project_files()
			builtin.find_files({ cwd = get_project_root() })
		end

		-- Wrapper for live_grep
		local function live_grep_project()
			builtin.live_grep({ cwd = get_project_root() })
		end

		-- Bindings using the wrappers
		vim.keymap.set('n', '<leader>ff', find_project_files, { desc = 'Find Project Files' })
		vim.keymap.set('n', '<leader>fs', live_grep_project, { desc = 'Live Grep Project' })
		
		-- Optional Git files mapping
		vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Git Search' })
	end
}
