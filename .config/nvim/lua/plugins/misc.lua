return {
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "jj" },
    },
    {
      "andymass/vim-matchup",
      setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
  },
}
