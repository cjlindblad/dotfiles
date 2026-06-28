return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      current_line_blame = false,
      attach_to_untracked = false,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("<leader>gn", function()
          gitsigns.nav_hunk("next")
        end, "Next git hunk")

        map("<leader>gp", function()
          gitsigns.nav_hunk("prev")
        end, "Previous git hunk")

        map("<leader>gv", gitsigns.preview_hunk, "Preview git hunk")
        map("<leader>gb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame current line")
        map("<leader>gc", function()
          gitsigns.setqflist("all")
        end, "All git hunks quickfix")
        map("<leader>gd", gitsigns.diffthis, "Diff current file")
        map("<leader>gq", gitsigns.setqflist, "Git hunks quickfix")
        map("<leader>gw", gitsigns.toggle_word_diff, "Toggle word diff")
      end,
    },
  },
}
