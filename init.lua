--============================================================
-- Core options
--============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.completeopt = "menuone,noselect"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "120"

vim.opt.splitbelow = true
vim.o.splitright = true

--============================================================
-- lazy.nvim bootstrap
--============================================================
local uv = vim.uv or vim.loop
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--============================================================
-- Plugins
--============================================================
require("lazy").setup({
  -- Theme: Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
    init = function()
      -- Keep this in init so it is set before :colorscheme
      vim.g.gruvbox_material_background = "hard" -- "soft" | "medium" | "hard"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 0
    end,
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- Treesitter
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

  -- Telescope
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

  -- Git signs
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- QoL
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", opts = {} },
  { "kylechui/nvim-surround", opts = {} },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        window = {
          completion = { max_height = 10, max_width = 60 },
          documentation = { max_height = 15, max_width = 80 },
        },
      })
    end,
  },

  -- File tree
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
})

--============================================================
-- Highlight fix
--============================================================
local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to, default = false })
end

local function apply_hl_fixes()
  link("StorageClass", "Keyword") -- cStorageClass -> StorageClass
  link("@storageclass", "Keyword")
  link("@keyword.storage", "Keyword")
  link("@keyword.return", "Keyword")
  link("Statement", "Keyword")
end

apply_hl_fixes()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_hl_fixes,
})

--============================================================
-- LSP: clangd (Neovim 0.11+)
--============================================================
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local caps = ok_cmp and cmp_lsp.default_capabilities() or nil

vim.lsp.config("clangd", {
  cmd = {
    vim.fn.expand("$HOME/.local/bin/clangd"),
    "--background-index",
    "-j=64",
    "--log=error",
    "--clang-tidy",
  },
  capabilities = caps,
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
    vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, { buffer = ev.buf, desc = "Incoming calls" })
    vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, { buffer = ev.buf, desc = "Outgoing calls" })
  end,
})

--============================================================
-- Clipboard (OSC52)
--============================================================
vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local b64 = vim.base64.encode(text)
      io.write(string.format("\027]52;c;%s\007", b64))
    end,
    ["*"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local b64 = vim.base64.encode(text)
      io.write(string.format("\027]52;c;%s\007", b64))
    end,
  },
  paste = {
    ["+"] = function()
      return { {}, "" }
    end,
    ["*"] = function()
      return { {}, "" }
    end,
  },
}

--============================================================
-- Keymaps
--============================================================
vim.keymap.set("n", "<C-Left>", "<C-w>>")
vim.keymap.set("n", "<C-Right>", "<C-w><")
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Down>", "<C-w>-")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("v", "<leader>cf", ":!clang-format<CR>", { silent = true })

