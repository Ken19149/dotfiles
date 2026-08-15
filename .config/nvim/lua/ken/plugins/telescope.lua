return {
	"nvim-telescope/telescope.nvim", 
	dependencies = { "nvim-lua/plenary.nvim" }, 

	config = function() 
		require("telescope").setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Git Search' })
	end
}

