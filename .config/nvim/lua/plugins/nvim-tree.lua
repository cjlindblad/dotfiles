return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFocus" },
    keys = {
      { "<leader>et", "<cmd>NvimTreeToggle<CR>", desc = "Tree explorer" },
    },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 35,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = false,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    },
  },
}
