-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sm", "<C-W>|", { desc = "Maximaze window" })

-- Tab management
keymap.set("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- text
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste text" })

-- Don't yank on put
keymap.set(
  "x",
  "p",
  'p<cmd>let @+=@0<CR><cmd>let @"=@0<CR>',
  { noremap = true, silent = true, desc = "Don't yank on put" }
)
keymap.set({ "n", "v" }, "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set({ "n", "v" }, "<leader>W", ":w<CR>", { desc = "Save file" })

-- Don't leave visual mode when changing indent
keymap.set("x", ">", ">gv", { noremap = true })
keymap.set("x", "<", "<gv", { noremap = true })

-- selection
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Jump to the beginning of the line" })
keymap.set({ "n", "x", "o" }, "L", "$", { desc = "Jump to the end of the line" })
keymap.set({ "n", "v" }, "<leader>a", "gg0<C-v>G$", { desc = "Select all" })

-- treesiter
keymap.set("n", "<leader>cti", ":InspectTree<CR>", { desc = "InspectTree" })

-- Clear search highlights easily
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Deleting text in visual mode without copying to clipboard
keymap.set("x", "d", '"_d', { desc = "Delete without copying" })

-- Close buffer
keymap.set("n", "<leader>q", "<cmd>close<CR>", { desc = "Close" })
