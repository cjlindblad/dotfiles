return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>cf",
        function()
          local has_oxfmt = #vim.lsp.get_clients({ bufnr = 0, name = "oxfmt" }) > 0
          if has_oxfmt then
            vim.lsp.buf.format({
              timeout_ms = 3000,
              filter = function(client)
                return client.name == "oxfmt"
              end,
            })
            return
          end

          require("conform").format({
            async = true,
            timeout_ms = 3000,
            lsp_format = "fallback",
          })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        typescript = { "oxfmt" },
        javascript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        javascriptreact = { "oxfmt" },
      },
      format_on_save = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, filetype) then
          return nil
        end

        return {
          timeout_ms = 3000,
          lsp_format = "fallback",
        }
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("oxfmt-lsp-format", { clear = true }),
        callback = function(event)
          local has_oxfmt = #vim.lsp.get_clients({ bufnr = event.buf, name = "oxfmt" }) > 0
          if not has_oxfmt then
            return
          end

          vim.lsp.buf.format({
            bufnr = event.buf,
            timeout_ms = 3000,
            filter = function(client)
              return client.name == "oxfmt"
            end,
          })
        end,
      })
    end,
  },
}
