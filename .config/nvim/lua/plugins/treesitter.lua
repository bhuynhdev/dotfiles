return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      matchup = { -- vim-matchup + treesitter integration: https://github.com/andymass/vim-matchup#tree-sitter-integration
        enable = true,
        disable = { "c", "ruby" }, -- optional, list of language that will be disabled
      },
    },
  },
}
