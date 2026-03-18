return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
    init = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 0
    end,
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
      require("config.highlights").apply()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
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
    cmd = { "Outline", "OutlineOpen", "OutlineClose", "OutlineFocus" },
    keys = {
      { "<leader>ou", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {},
  },
}