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
      commands = {
        copy_selector = function(state) -- Copy filepath: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["1. BASENAME"] = modify(filename, ":r"),
            ["2. EXTENSION"] = modify(filename, ":e"),
            ["3. FILENAME"] = filename,
            ["4. PATH (CWD)"] = modify(filepath, ":."),
            ["5. PATH (HOME)"] = modify(filepath, ":~"),
            ["6. PATH"] = filepath,
            ["7. URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ""
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item)
              return ("%s: %s"):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,
      },
      window = {
        position = "right",
        mappings = {
          ["Y"] = "copy_selector",
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
