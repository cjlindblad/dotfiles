return {
  {
    "stevearc/oil.nvim",
    lazy = false, -- load immediately so `-` works everywhere
    keys = {
      { "<leader>ee", "<cmd>Oil<CR>", desc = "Oil explorer" },
    },
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      -- Disable default keymaps so only ours apply
      use_default_keymaps = false,
    },
  },
}
