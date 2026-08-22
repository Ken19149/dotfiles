return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      -- Tells Neovim to use Oil instead of netrw when opening directories
      default_file_explorer = true,
      
      -- Optional: you can customize the floating window or keep it as a standard buffer
      view_options = {
        show_hidden = true, -- Show hidden files by default
      },
    })
    
    -- The standard keybind to open the parent directory of your current file
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
