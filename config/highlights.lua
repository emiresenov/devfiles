local M = {}

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to, default = false })
end

function M.apply()
  link("StorageClass", "Keyword")
  link("@storageclass", "Keyword")
  link("@keyword.storage", "Keyword")
  link("@keyword.return", "Keyword")
  link("Statement", "Keyword")
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#fb4934", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#fabd2f", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#83a598", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#8ec07c", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#fb4934" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#fabd2f" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#83a598" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#8ec07c" })
end

return M