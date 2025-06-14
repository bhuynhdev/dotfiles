return {
  "folke/snacks.nvim",

  opts = {
    picker = {
      actions = {
        explorer_paste_rename = function(picker)
          local uv = vim.uv or vim.loop
          local Tree = require("snacks.explorer.tree")
          local M = require("snacks.explorer.actions")

          local files = vim.split(vim.fn.getreg(vim.v.register or "+") or "", "\n", { plain = true })
          files = vim.tbl_filter(function(file)
            return file ~= "" and vim.fn.filereadable(file) == 1
          end, files)

          if #files == 0 then
            return Snacks.notify.warn(("The `%s` register does not contain any files"):format(vim.v.register or "+"))
          end
          if #files == 1 then
            -- If only one file in buffer, we ask what new name to change to
            local file = files[1]
            local base = vim.fn.fnamemodify(file, ":t")
            local dir = picker:dir()
            Snacks.input(
              { prompt = "Rename pasted file", default = base, },
              function(value)
                if not value or value:find("^%s*$") then
                  return
                end
                local target = vim.fs.normalize(dir .. "/" .. value)
                if uv.fs_stat(target) then
                  Snacks.notify.warn("File already exists:\n- `" .. target .. "`")
                  return
                end
                Snacks.picker.util.copy_path(file, target)
                Tree:refresh(dir)
                Tree:open(dir)
                M.update(picker, { target = dir })
              end
            )
          else
            -- If multiple files, than just paste like normal without rename
            -- Thus will error if file already exists
            local dir = picker:dir()
            Snacks.picker.util.copy(files, dir)
            Tree:refresh(dir)
            Tree:open(dir)
            M.update(picker, { target = dir })
          end
        end,
      },

      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["R"] = "explorer_paste_rename",
              },
            },
          },
        },
      },
    },
  },

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
