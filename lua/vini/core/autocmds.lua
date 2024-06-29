-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local create_command = vim.api.nvim_create_user_command

create_command("SaveWithoutFormat", ":noautocmd w", { nargs = 0, desc = "Save file without auto-commands" })
create_command("CopyRelativePath", ":let @+ = expand('%:p')", { nargs = 0, desc = "Copy relative path" })
