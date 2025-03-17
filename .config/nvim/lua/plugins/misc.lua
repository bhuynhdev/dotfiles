return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
  },
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    -- https://github.com/folke/noice.nvim
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          -- Set not show a message if hover is not available
          -- https://github.com/LazyVim/LazyVim/discussions/830
          silent = true,
        },
      },
    },
  },
}
