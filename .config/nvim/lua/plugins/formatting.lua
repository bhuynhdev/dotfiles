return {
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts ConformOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local supported = { "javascript", "typescript", "jsx", "tsx" }
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettierd")
      end

      opts.formatters = opts.formatters or {}
      -- opts.formatters.prettier = {
      --   condition = function(_, ctx)
      --     return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
      --   end,
      -- }
    end,
  },
}