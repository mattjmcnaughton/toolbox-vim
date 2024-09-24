return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "rust", "go", "typescript", "bash", "lua", "haskell", "r",
        "python", "json", "yaml", "nix", "dockerfile", "sql", "c",
        "gitcommit", "markdown", "tsx"
      },

      sync_install = true,
      auto_install = true,

      indent = {
        enable = true
      },
    })
  end
}
