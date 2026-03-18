return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      ts.setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}