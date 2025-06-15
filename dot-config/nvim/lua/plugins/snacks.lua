-- Applies a `fnamemodify` modifier to a list of file paths and returns the modified paths as a newline-separated string.
--
-- Example:
--   mass_fname_modify({ "src/main.lua", "README.md" }, ":r")  "src/main\nREADME"
--
---@param file_list string[]  -- A list of file paths to transform
---@param mod string         -- Modifier string for fnamemodify (e.g., ":t", ":p:h", ":r", etc.)
---@return string             -- Modified file paths joined by "\n"
local function mass_fname_modify(file_list, mod)
  return table.concat(
    vim.tbl_map(function(file)
      return vim.fn.fnamemodify(file, mod)
    end, file_list),
    "\n"
  )
end

local Tree = require("snacks.explorer.tree")
local M = require("snacks.explorer.actions")

return {
  "folke/snacks.nvim",

  opts = {
    picker = {
      actions = {
        explorer_yank_paths = function(picker)
          -- Adapted from: https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/lua/snacks/explorer/actions.lua#L88
          -- and https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/lua/snacks/explorer/actions.lua#L197
          -- Original idea is from: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
          local files = {} ---@type string[]
          if vim.fn.mode():find("^[vV]") then
            picker.list:select()
          end
          for _, item in ipairs(picker:selected({ fallback = true })) do
            table.insert(files, Snacks.picker.util.path(item))
          end

          local modify = vim.fn.fnamemodify

          if #files >= 1 then
            local representative_file = files[1] -- In case we selected multiple files, we only show sample paths for first file
            local options = {
              {
                description = "BASENAME " .. modify(representative_file, ":r"),
                fn = function()
                  return mass_fname_modify(files, ":r")
                end,
              },
              {
                description = "EXTENSION " .. modify(representative_file, ":e"),
                fn = function()
                  return mass_fname_modify(files, ":e")
                end,
              },
              {
                description = "FILENAME " .. modify(representative_file, ":t"),
                fn = function()
                  return mass_fname_modify(files, ":t")
                end,
              },
              {
                description = "PATH (CWD) " .. modify(representative_file, ":."),
                fn = function()
                  return mass_fname_modify(files, ":.")
                end,
              },
              {
                description = "PATH (HOME) " .. modify(representative_file, ":~"),
                fn = function()
                  return mass_fname_modify(files, ":~")
                end,
              },
              {
                description = "PATH " .. representative_file,
                fn = function()
                  return files
                end,
              },
              {
                description = "URI " .. vim.uri_from_fname(representative_file),
                fn = function()
                  return table.concat(vim.tbl_map(vim.uri_from_fname, files), "\n")
                end,
              },
            }

            local descriptions = vim.tbl_map(function(item)
              return item.description
            end, options)

            local target = picker:dir()

            Snacks.picker.select(descriptions, { prompt = "Choose to copy to clipboard" }, function(_, idx)
              if idx ~= nil then
                local text = options[idx].fn()
                vim.fn.setreg(vim.v.register or "+", text, "1")
                Snacks.notify.info("Copied to clipboard")
                Tree:refresh(target)
                M.update(picker, { target = target })
              end
            end)
          end
        end,
      },

      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["Y"] = "explorer_yank_paths",
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
