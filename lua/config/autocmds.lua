vim.api.nvim_create_autocmd({"VimResized","FocusGained"}, {
  callback = function()
    vim.cmd("wincmd =")
    vim.cmd("redraw!")
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("config.highlights").apply()
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})