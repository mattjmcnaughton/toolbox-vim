return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    { "stevearc/conform.nvim", branch = "nvim-0.9" },
    "mfussenegger/nvim-lint",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    -- ############## initial config ###############

    require("mason").setup()

    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")

    local capabilities =
        vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    -- ############## lsp ###############

    require("mason-lspconfig").setup({
      -- We can only include lsp servers in here (i.e. not the full set of linters,
      -- formatters, etc... offered via Mason.
      ensure_installed = {
        "gopls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
      },

      handlers = {
        function(server_name) -- default handler
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- can override per lsp -- ["lsp_name"] = function()...
      },
    })

    -- ############## complete ###############
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<TAB>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- for luasnip users.
      }, {
        { name = "buffer" },  -- text contained within the buffer
        { name = "path" },
      }),
    })

    -- ############## fmt ###############

    require("conform").setup({
      formatters_by_ft = {
        lua = { lsp_format = "fallback" },
        go = { "gofmt", lsp_format = "fallback" },
        markdown = { lsp_format = "fallback" },
      },
      format_on_save = {
        -- Fallback to the lsp
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ async = true })
    end, { desc = "Format via conform.nvim" })

    -- ############## lint ###############
    require("lint").linters_by_ft = {}

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })
  end,
}
