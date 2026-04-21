return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          lualine = true,
          gitsigns = true,
          treesitter = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")
      require("config.highlights").apply()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen", "Outlineclose", "OutlineFocus" },
    keys = {
      { "<leader>ou", "<cmd>Outline<cr>", desc = "toggle outline" },
    },
    opts = {},
  },
}