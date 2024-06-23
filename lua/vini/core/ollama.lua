local chat_context = {}

local chat = function(opts)
  local endpoint = "http://localhost:11434/api/generate"
  local model = "granite-code:3b"
  local prompt = "CONTEXT: You are an IA assistant with solve math problems. When I ask you to resolve an algorithm, just say the awnser. PROBLEM TO SOLVE: "
    .. opts.args

  local json_prompt = vim.fn.json_encode({
    model = model,
    prompt = prompt,
    context = chat_context,
    stream = false,
  })

  local args = {
    "-s",
    endpoint,
    "-d",
    json_prompt,
  }

  print(vim.inspect(args))

  local on_finish = function(result)
    vim.schedule(function()
      local data = vim.fn.json_decode(table.concat(result, ""))

      if data.context then
        chat_context = data.context
      end

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

create_command("AIChat", function(opts)
  chat(opts)
end, { nargs = 1, desc = "Chat with AI" })
