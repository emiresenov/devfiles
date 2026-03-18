return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local tb = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<Del>"] = "delete_buffer" },
            n = { ["<Del>"] = "delete_buffer" },
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Help" })
      vim.keymap.set("n", "<leader>ss", tb.lsp_document_symbols, { desc = "Document symbols" })
    end,
  },

  {
    "jmacadie/telescope-hierarchy.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("hierarchy")
    end,
    keys = {
      { "<leader>ci", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "Hierarchy: incoming calls" },
      { "<leader>co", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "Hierarchy: outgoing calls" },
    },
  },
}