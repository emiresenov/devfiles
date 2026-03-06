local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local caps = ok_cmp and cmp_lsp.default_capabilities() or nil

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  capabilities = caps,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.enable("clangd")
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Line diagnostics" })
  end,
})