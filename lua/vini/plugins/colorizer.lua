return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    local colorizer = require("colorizer")
    -- local opt = {
    --   css = true,
    --   "css",
    --   "javascript",
    --   html = {
    --     mode = "foreground",
    --   },
    -- }
    colorizer.setup({})
  end,
}
