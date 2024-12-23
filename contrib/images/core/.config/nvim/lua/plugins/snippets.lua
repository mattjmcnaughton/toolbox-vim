return {
  {
    "L3MON4D3/LuaSnip",

    build = "make install_jsregexp",

    -- We currently do not install rafamadriz/friendly-snippets.
    -- We may add later.

    config = function()
      -- re https://github.com/rafamadriz/friendly-snippets?tab=readme-ov-file#with-lazynvim
      require("luasnip.loaders.from_vscode").lazy_load()

      -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      local ls = require("luasnip")
      -- use ctrl-l and ctrl-h to navigate through the snippet options and ctrl-e to exit.
      vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-h>", function() ls.jump(-1) end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  }
}
