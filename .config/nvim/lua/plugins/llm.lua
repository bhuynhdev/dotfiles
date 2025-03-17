return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      cursor_applying_provider = "ollama",
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      ollama = {
        model = "qwen2.5-coder:7b",
      },
      windows = {
        position = "left",
        ask = {
          start_insert = false,
        },
      },
    },
    file_selector = {
      provider = "fzf",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "echasnovski/mini.icons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- {
  --   "codota/tabnine-nvim",
  --   build = "./dl_binaries.sh",
  --   config = function()
  --     require("tabnine").setup({
  --       disable_auto_comment = true,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#808080", cterm = 244 },
  --       codelens_color = { gui = "#808080", cterm = 244 },
  --       codelens_enabled = true,
  --       exclude_filetypes = { "TelescopePrompt", "NvimTree" },
  --       log_file_path = nil, -- absolute path to Tabnine log file,
  --       ignore_certificate_errors = false,
  --     })
  --   end,
  -- },
  {
    "huggingface/llm.nvim",
    opts = {
      backend = "ollama",
      accept_keymap = "<Tab>",
      dismiss_keymap = "<S-Tab>",
      model = "starcoder2:3b",
      url = "http://localhost:11434",
      tokens_to_clear = { "<|endoftext|>", "<|file_separator|>" },
      context_window = 1024,
      fim = {
        enabled = true,
        prefix = "<|fim_prefix|>",
        miidle = "<|fim_middle|>",
        suffix = "<|fim_suffix|>",
      },
      -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
      request_body = {
        options = {
          top_k = 5,
          temperature = 0.1,
          top_p = 0.3,
          num_predict = 1024,
          stop = {
            "<|im_start|>",
            "<|im_end|>",
            "<|fim_suffix|>",
            "<fim_suffix>",
            "<|fim_prefix|>",
            "<fim_prefix>",
            "<|fim_middle|>",
            "<fim_middle>",
            "</fim_middle>",
            "<|fim_end|>",
            "<fim_end>",
            "<|file_separator|>",
            "<file_sep>",
            "<|end_of_text|>",
          },
        },
      },
    },
  },
}
