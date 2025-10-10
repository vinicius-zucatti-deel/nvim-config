-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-x>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-a>", { desc = "Decrement number" }) -- decrement

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sm", ":vertical resize 170%<CR>", { desc = "Maximaze vertical window" })
-- keymap.set("n", "<leader>sm", "<C-W>|", { desc = "Maximaze window" })

-- Tab managemen
keymap.set("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- keymap.set("n", "<leader>Tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- keymap.set("n", "<leader>Tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
-- keymap.set("n", "<leader>Tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
-- keymap.set("n", "<leader>Tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
-- Tabs
-- keymap.set("n", "tn", ":tabnew<CR>", { silent = true }) -- new tab
-- keymap.set("n", "tk", ":tabnext<CR>", { silent = true }) -- next tab
-- keymap.set("n", "tj", ":tabprev<CR>", { silent = true }) -- previous tab
-- keymap.set("n", "tq", ":tabclose<CR>", { silent = true }) -- close tab

-- text
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste text" })

--terminal
-- open terminal bottom
keymap.set("n", "<leader>X", ":belowright split | terminal<CR>", { desc = "Open terminal bottom" })

-- exit terminal mode easily with <Esc>
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Don't yank on put
keymap.set(
  "x",
  "p",
  'p<cmd>let @+=@0<CR><cmd>let @"=@0<CR>',
  { noremap = true, silent = true, desc = "Don't yank on put" }
)
keymap.set({ "n", "v" }, "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set({ "n", "v" }, "<leader>W", ":noautocmd w<CR>", { desc = "Save file without auto-commands" })

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
keymap.set("n", "<leader>H", ":nohl<CR>", { desc = "Clear search highlights" })

-- Deleting text in visual and normal mode without copying to clipboard
keymap.set({ "x", "n" }, "d", '"_d', { desc = "Delete without copying" })

-- Close buffer
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close" })
keymap.set("n", "<leader>Qa", ":qa<CR>", { desc = "Quit all" })

-- Moving
keymap.set("n", "<C-p>", "<C-^>", { desc = "Go to previous file" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump up and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump down and center" })

-- NVIM 11 Config
-- Remove Global Default Key mapping
keymap.del("n", "grn")
keymap.del("n", "gra")
keymap.del("n", "grr")
keymap.del("n", "gri")
keymap.del("n", "gO")

-- Buffer hover
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

-- NVChad inspired https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua
keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
-- Comment
keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
-- keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
keymap.set(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "telescope find in current buffer" }
)
keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
-- whichkey
keymap.set("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

keymap.set("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- Jump to next diagnostic
-- keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
--
-- -- Jump to previous diagnostic
-- keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
--
-- -- Show diagnostic under cursor (popup)
-- keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
--
-- -- Show diagnostics list
-- keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
