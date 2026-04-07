local active_profile = "-work"

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal_cmd = "claude",
		log_level = "warn",
	},
	config = function(_, opts)
		vim.env.CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude" .. active_profile)

		local plugin = require("claudecode")
		plugin.setup(opts)

		local function switch_and_launch(profile_suffix)
			if active_profile == profile_suffix then
				vim.cmd("ClaudeCode")
				return
			end

			active_profile = profile_suffix
			vim.env.CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude" .. active_profile)
			vim.fn.mkdir(vim.env.CLAUDE_CONFIG_DIR, "p")

			-- Close if open, then reopen after env is set
			vim.cmd("ClaudeCode") -- toggle close
			vim.defer_fn(function()
				vim.cmd("ClaudeCode") -- reopen with new env
				vim.notify(
					"Claude account: " .. (profile_suffix == "-work" and "Work" or "Personal"),
					vim.log.levels.INFO
				)
			end, 1000)
		end

		vim.api.nvim_create_user_command("ClaudePersonal", function()
			switch_and_launch("-personal")
		end, {})

		vim.api.nvim_create_user_command("ClaudeWork", function()
			switch_and_launch("-work")
		end, {})
	end,
	keys = {
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		{ "<leader>ap", "<cmd>ClaudePersonal<cr>", desc = "Switch to Personal Claude" },
		{ "<leader>aw", "<cmd>ClaudeWork<cr>", desc = "Switch to Work Claude" },
		{ "<C-n>", "<C-\\><C-n>", mode = "t", desc = "Enter normal mode in Claude terminal" },
	},
}
