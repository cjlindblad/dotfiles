return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local parsers = {
        "typescript",
        "javascript",
        "tsx",
        "c_sharp",
        "json",
        "html",
        "css",
        "lua",
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
        "bash",
      }

      -- Install any missing parsers
      local installed = require("nvim-treesitter").get_installed()
      local to_install = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, parsers)

      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end
    end,
  },
}
