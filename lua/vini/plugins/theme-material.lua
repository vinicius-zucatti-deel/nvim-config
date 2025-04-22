return {
  "marko-cerovac/material.nvim",
  priority = 1000,
  config = function()
    -- vim.g.material_style = "darker"
    -- vim.g.material_style = "lighter"
    -- vim.g.material_style = "oceanic"
    -- vim.g.material_style = "palenight"
    vim.g.material_style = "deep ocean"
    vim.cmd("colorscheme material")
  end,
}
