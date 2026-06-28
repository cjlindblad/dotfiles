return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    config = function()
      -- Setup mason first
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "omnisharp",
          "lua_ls",
          "ols",
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps (attached when LSP connects to a buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          -- Navigation
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("gt", vim.lsp.buf.type_definition, "Go to type definition")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("gK", vim.lsp.buf.signature_help, "Signature help")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")

          if client and client.name == "omnisharp" then
            local omnisharp_extended = require("omnisharp_extended")
            map("gd", omnisharp_extended.telescope_lsp_definition, "Go to definition")
            map("gr", omnisharp_extended.telescope_lsp_references, "References")
            map("gi", omnisharp_extended.telescope_lsp_implementation, "Go to implementation")
            map("gt", omnisharp_extended.telescope_lsp_type_definition, "Go to type definition")
          end

          -- Code actions
          map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
          map("g.", vim.lsp.buf.code_action, "Code actions")

          -- Diagnostics
          map("<leader>dd", vim.diagnostic.setloclist, "Diagnostics list")
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("<leader>dl", vim.diagnostic.open_float, "Line diagnostics")
        end,
      })

      -- TypeScript / JavaScript (diagnostics disabled — oxlint handles linting)
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      })

      -- Oxlint (linter via LSP — provides diagnostics for JS/TS)
      vim.lsp.enable("oxlint")

      -- Oxfmt (formatter via LSP — avoids spawning oxfmt on every save)
      vim.lsp.enable("oxfmt")

      -- C#
      vim.lsp.config("omnisharp", {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/bin/OmniSharp",
          "-z",
          "--hostPID",
          tostring(vim.fn.getpid()),
          "DotNet:enablePackageRestore=false",
          "--encoding",
          "utf-8",
          "--languageserver",
        },
        capabilities = capabilities,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableDecompilationSupport = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      })
      vim.lsp.enable("omnisharp")

      -- Lua (for editing nvim config)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Odin (uses lspconfig defaults; ols installed via mason)
      vim.lsp.enable("ols")

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        float = { border = "rounded" },
      })
    end,
  },

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
  },
}
