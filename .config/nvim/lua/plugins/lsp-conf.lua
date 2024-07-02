return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        lemminx = {
          init_options = {
            settings = {
              -- All formatting options: https://github.com/redhat-developer/vscode-xml/blob/main/docs/Formatting.md
              xml = {
                format = {
                  enabled = true,
                  splitAttributes = "preserve",
                  maxLineWidth = 280,
                },
              },
              xslt = {
                format = {
                  enabled = true,
                  splitAttributes = "preserve",
                  maxLineWidth = 280,
                },
              },
            },
          },
        },
      },
    },
  },
}
