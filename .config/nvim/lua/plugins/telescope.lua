return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "Search files" },
      { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search buffer" },
      { "<leader>fc", "<cmd>Telescope git_status<CR>", desc = "Changed files" },
      {
        "<leader>bb",
        function()
          require("telescope.builtin").buffers({
            attach_mappings = function(_, map)
              local actions = require("telescope.actions")
              map("i", "<C-d>", actions.delete_buffer)
              map("n", "d", actions.delete_buffer)
              return true
            end,
          })
        end,
        desc = "Buffers",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      {
        "gs",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Constructor",
              "Enum",
              "Function",
              "Interface",
              "Method",
              "Module",
              "Namespace",
              "Struct",
              "Variable",
              "Constant",
            },
          })
        end,
        desc = "Document symbols",
      },
      { "gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      {
        "gS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = {
              "Class",
              "Enum",
              "Function",
              "Interface",
              "Method",
              "Module",
              "Namespace",
              "Struct",
            },
          })
        end,
        desc = "Workspace symbols",
      },
    },
    opts = function()
      return {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "bin/", "obj/" },
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({
            layout_config = {
              height = function(_, _, max_lines)
                return math.min(max_lines, 25)
              end,
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("ui-select")
    end,
  },
}
