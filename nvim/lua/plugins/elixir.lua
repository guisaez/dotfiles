return {
  "elixir-tools/elixir-tools.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("elixir").setup()
  end
}
