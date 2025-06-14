return {
  "folke/snacks.nvim",

  keys = {
    {
      -- Focus Explorer: https://github.com/folke/snacks.nvim/discussions/1273
      "<leader>h",
      function()
        local explorer_pickers = Snacks.picker.get({ source = "explorer" })
        for _, v in pairs(explorer_pickers) do
          v:focus()
        end
        if #explorer_pickers == 0 then
          Snacks.picker.explorer()
        end
      end,
      desc = "Focus explorer",
    },
  },
}
