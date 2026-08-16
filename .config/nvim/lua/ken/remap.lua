vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--[[
vim.keymap.set("n", "m", "h") -- left
vim.keymap.set("n", "n", "j") -- down
vim.keymap.set("n", "e", "k") -- up
vim.keymap.set("n", "i", "l") -- right
--]]

vim.keymap.set("n", "<C-n>", "<C-d>zz")
vim.keymap.set("n", "<C-e>", "<C-u>zz")

-- Make Ctrl+Arrows (from QMK Nav Layer) jump words
vim.keymap.set("n", "<C-Left>", "b", { desc = "Jump word backward" })
vim.keymap.set("n", "<C-Right>", "w", { desc = "Jump word forward" })

-- And make them work in Visual Mode too!
vim.keymap.set("v", "<C-Left>", "b", { desc = "Jump word backward" })
vim.keymap.set("v", "<C-Right>", "w", { desc = "Jump word forward" })

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

-- Force reliance on the QMK Navigation Layer
-- Disable traditional hjkl movement in Normal Mode
vim.keymap.set("n", "h", "<Nop>", { desc = "Disabled: Use QMK Nav Layer" })
vim.keymap.set("n", "j", "<Nop>", { desc = "Disabled: Use QMK Nav Layer" })
vim.keymap.set("n", "k", "<Nop>", { desc = "Disabled: Use QMK Nav Layer" })
vim.keymap.set("n", "l", "<Nop>", { desc = "Disabled: Use QMK Nav Layer" })

-- Disable traditional hjkl movement in Visual Mode
vim.keymap.set("v", "h", "<Nop>")
vim.keymap.set("v", "j", "<Nop>")
vim.keymap.set("v", "k", "<Nop>")
vim.keymap.set("v", "l", "<Nop>")
