vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--[[
vim.keymap.set("n", "m", "h") -- left
vim.keymap.set("n", "n", "j") -- down
vim.keymap.set("n", "e", "k") -- up
vim.keymap.set("n", "i", "l") -- right
--]]

vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

-- vim.keymap.set("n", "<C-n>", "<C-d>zz", { noremap = true })
-- vim.keymap.set("n", "<C-e>", "<C-u>zz", { noremap = true })

--[[
vim.keymap.set("n", "<C-n>", function()
  vim.cmd("normal! <C-d>zz")
end, { silent = true })

vim.keymap.set("n", "<C-e>", function()
  vim.cmd("normal! <C-u>zz")
end, { silent = true })
--]]
