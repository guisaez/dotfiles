local active_profile = "default"

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		log_level = "error",
		terminal = {
			split_width_percentage = 0.5,
		},
		diff_opts = {
			layout = "horizontal",
			open_in_new_tab = true,
			keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
			hide_terminal_in_new_tab = true,
		},
	},
	config = function(_, opts)
		local function sync_claude_env(profile)
			if profile == "default" then
				vim.env.CLAUDE_CONFIG_DIR = nil
			else
				vim.env.CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude" .. profile)
				vim.fn.mkdir(vim.env.CLAUDE_CONFIG_DIR, "p")
			end
		end

		-- Initialize the default profile on startup
		sync_claude_env(active_profile)

		local plugin = require("claudecode")
		plugin.setup(opts)

		local function kill_claude_terminal()
			local killed = false
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if not vim.api.nvim_buf_is_valid(buf) then
					goto continue
				end
				local ok, buftype = pcall(function()
					return vim.bo[buf].buftype
				end)
				if ok and buftype == "terminal" and vim.api.nvim_buf_get_name(buf):match("claude") then
					local job_id = vim.b[buf].terminal_job_id
					if job_id then
						pcall(vim.fn.jobstop, job_id)
					end
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
					killed = true
				end
				::continue::
			end
			return killed
		end

		local function switch_profile(new_profile)
			if active_profile == new_profile then
				vim.cmd("ClaudeCode")
				return
			end

			active_profile = new_profile
			sync_claude_env(active_profile)
			vim.notify("Claude: " .. active_profile:gsub("^%l", string.upper))

			local was_running = kill_claude_terminal()
			if was_running then
				-- Suppress expected errors from force-killing Claude (exit -1, ECONNRESET)
				local orig_notify = vim.notify
				vim.notify = function(msg, ...)
					if type(msg) == "string" and (msg:match("exited with code %-1") or msg:match("ECONNRESET")) then
						return
					end
					return orig_notify(msg, ...)
				end
				vim.defer_fn(function()
					vim.notify = orig_notify
					vim.cmd("ClaudeCode")
				end, 500)
			end
		end

		-- Buffer-local <Esc> to exit terminal mode only in Claude terminals
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*claude*",
			callback = function(ev)
				vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = ev.buf, desc = "Exit terminal mode" })
			end,
		})

		-- User Commands
		vim.api.nvim_create_user_command("ClaudeWork", function()
			switch_profile("-work")
		end, {})
		vim.api.nvim_create_user_command("ClaudePersonal", function()
			switch_profile("-personal")
		end, {})
		vim.api.nvim_create_user_command("ClaudeDefault", function()
			switch_profile("default")
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
		{ "<leader>aw", "<cmd>ClaudeWork<cr>", desc = "Switch to Work (API Key)" },
		{ "<leader>ap", "<cmd>ClaudePersonal<cr>", desc = "Switch to Personal (API Key)" },
		{ "<leader>ax", "<cmd>ClaudeDefault<cr>", desc = "Switch to Standard (OAuth)" },
		{ "<C-n>", "<C-\\><C-n>", mode = "t", desc = "Enter normal mode in Claude terminal" },
	},
}
