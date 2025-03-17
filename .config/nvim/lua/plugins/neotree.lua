return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>ee",
        function()
          require("neo-tree.command").execute({})
        end,
        desc = "Focus Neotree",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          always_show = { ".gitignore" },
        },
      },
      window = {
        position = "right",
        mappings = {
          ["<Tab>"] = {
            function(state)
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open"](state)
                vim.cmd("Neotree reveal")
                -- vim.cmd('Neotree float toggle reveal_force_cwd dir=' .. vim.fn.getcwd()) -- I use this one.
              end
            end,
            desc = "Open but keep focus on Neotree", -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
          },
        },
      },
    },
  },
}
