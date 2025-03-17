return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        perlnavigator = {
          settings = {
            perlnavigator = {
              includePaths = vim.fn.glob(vim.fn.getcwd() .. "/*/lib", false, 1),
            },
          },
        },
        lemminx = {
          init_options = {
            settings = {
              -- All formatting options: https://github.com/redhat-developer/vscode-xml/blob/main/docs/Formatting.md
              xml = {
                format = {
                  enabled = true,
                  splitAttributes = "preserve",
                  maxLineWidth = 280,
                  preservedNewlines = 1,
                },
              },
              xslt = {
                format = {
                  enabled = true,
                  splitAttributes = "preserve",
                  maxLineWidth = 280,
                  preservedNewlines = 1,
                },
              },
            },
          },
        },
      },
    },
  },
}
