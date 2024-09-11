-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local create_command = vim.api.nvim_create_user_command

create_command("SaveWithoutFormat", ":noautocmd w", { nargs = 0, desc = "Save file without auto-commands" })
create_command("CopyRelativePath", ":let @+ = expand('%:p')", { nargs = 0, desc = "Copy relative path" })

local instruction_replace_all = function()
  vim.api.nvim_echo({
    { ":args **/*.ext | argdo %s/old_string/new_string/gc | update" },
    { "\n" },
    { "y to confirm the change.", "Normal" },
    { "\n" },
    { "n to skip the current match.", "Normal" },
    { "\n" },
    { "a to replace all occurrences without asking further.", "Normal" },
    { "\n" },
    { "q to quit the replacement process.", "Normal" },
    { "\n" },
    { "l to replace the current match and then quit.", "Normal" },
  }, true, {})
end

create_command(
  "InstructionReplaceAll",
  instruction_replace_all,
  { desc = "Print the instructions for replace all occurrencesc" }
)
