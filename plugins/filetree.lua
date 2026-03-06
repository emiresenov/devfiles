return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
      vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file in tree" })
    end,
  },
}