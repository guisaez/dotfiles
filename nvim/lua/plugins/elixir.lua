return {
	"elixir-tools/elixir-tools.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local elixir = require("elixir")

		elixir.setup({
			-- Disable old servers
			elixirls = { enable = false },
			nextls = { enabled = false },
		})

		vim.lsp.config("expert", {
			root_markers = { "mix.exs", ".git" },
			filetypes = { "elixir", "eelixir", "heex" },
		})

		vim.lsp.enable("expert")
	end,
}
