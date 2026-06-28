return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register group labels
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>b", group = "Buffers" },
        { "<leader>e", group = "Explorer" },
        { "<leader>g", group = "Git" },
        { "<leader>w", group = "Windows" },
      })
    end,
  },
}
