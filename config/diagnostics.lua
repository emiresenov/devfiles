vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "always",
  },
})