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