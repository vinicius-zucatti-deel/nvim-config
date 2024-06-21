-- TODO: the context shold persist
local chat_context = {}

local chat = function(opts)
  local endpoint = "http://localhost:11434/api/generate"
  local model = "granite-code:3b"
  local prompt = "CONTEXT: You are an IA assistant with solve math problems. When I ask you to resolve an algorithm, just say the awnser. PROBLEM TO SOLVE:"
    .. opts.args

  local json_prompt = vim.fn.json_encode(prompt)
  -- BUG: We add the context is not reactive

  print("debug:", unpack(chat_context))

  local args = {
    "-s",
    endpoint,
    "-d",
    string.format('{"model": "%s", "prompt": %s, "stream": false}', model, json_prompt),
  }

  local on_finish = function(result)
    vim.schedule(function()
      local data = vim.fn.json_decode(result[1])
      -- BUG: It not update globaly
      chat_context = data.context

      local chat_response = vim.inspect(data.response)
      vim.cmd("tabnew")
      vim.api.nvim_put({ chat_response }, "b", true, true)
    end)
  end

  local Job = require("plenary.job")

  Job:new({
    command = "curl",
    args = args,
    on_exit = function(self, code, signal)
      local result = self:result()
      on_finish(result)
    end,
  }):start()
end

local create_command = vim.api.nvim_create_user_command

create_command("AIChat", chat, { nargs = 1, desc = "Chat with AI" })
