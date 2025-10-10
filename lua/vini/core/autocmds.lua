-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local create_command = vim.api.nvim_create_user_command

create_command("SaveWithoutFormat", ":noautocmd w", { nargs = 0, desc = "Save file without auto-commands" })
-- create_command("CopyRelativePath", ":let @+ = expand('%:p')", { nargs = 0, desc = "Copy relative path" })

-- local instruction_replace_all = function()
--   -- Prompt user for input
--   local file_pattern = vim.fn.input("Enter file pattern (e.g., src/**/*.js): ")
--   local old_string = vim.fn.input("Enter old string: ")
--   local new_string = vim.fn.input("Enter new string: ")
--
--   -- Display instructions
--   -- vim.api.nvim_echo({
--   --   {
--   --     "Command to execute: :args "
--   --       .. file_pattern
--   --       .. " | argdo %s/"
--   --       .. old_string
--   --       .. "/"
--   --       .. new_string
--   --       .. "/gc | update\n",
--   --     "Normal",
--   --   },
--   --   { "y to confirm each change.\n", "Normal" },
--   --   { "n to skip the current match.\n", "Normal" },
--   --   { "a to replace all occurrences without asking further.\n", "Normal" },
--   --   { "q to quit the replacement process.\n", "Normal" },
--   --   { "l to replace the current match and then quit.\n", "Normal" },
--   -- }, false, {})
--
--   -- Execute the command
--   vim.cmd("args " .. file_pattern)
--   vim.cmd("argdo %s/" .. old_string .. "/" .. new_string .. "/gc | update")
-- end
-- TODO: FIX IT
-- create_command(
--   "InstructionReplaceAll",
--   instruction_replace_all,
--   { desc = "Print the instructions for replace all occurrencesc" }
-- )

create_command("MyHelp", ":vsplit ~/.config/nvim/lua/vini/help.md", { nargs = 0, desc = "Open my custom help" })

-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--      vim.lsp.buf.hover()
--    end,
--    desc = "Auto-hover LSP docs on cursor hold",
-- })
