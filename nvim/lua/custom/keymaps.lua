-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Delete witout saving to register
vim.keymap.set({ "n", "v" }, "<leadder>d", '"_d')

-- Copy to the clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from the clipboard
vim.keymap.set("n", "<leader>p", '"+p"')

-- LOL
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Format buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat Current Buffer" })

-- Diagnostic keymaps

-- Open Quickfix
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Open full diagnostic message in a floating window (wraps long messages)
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- [[ Pane / Window management ]]
--  See `:help wincmd` for a list of all window commands

-- Navigate between panes
vim.keymap.set("n", "<leader>wh", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>wl", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>wj", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<leader>wk", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Create splits (with new empty buffer)
vim.keymap.set("n", "<leader>wv", "<cmd>vnew<CR>", { desc = "[W]indow [V]ertical split" })
vim.keymap.set("n", "<leader>ws", "<cmd>new<CR>", { desc = "[W]indow [S]plit horizontal" })

-- Close panes
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "[W]indow [C]lose" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "[W]indow close [O]thers" })

-- Move window to edge
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "[W]indow move to far left" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "[W]indow move to far right" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "[W]indow move to bottom" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "[W]indow move to top" })

-- Resize panes
vim.keymap.set("n", "<leader>w+", "<C-w>+", { desc = "[W]indow increase height" })
vim.keymap.set("n", "<leader>w-", "<C-w>-", { desc = "[W]indow decrease height" })
vim.keymap.set("n", "<leader>w>", "<C-w>>", { desc = "[W]indow increase width" })
vim.keymap.set("n", "<leader>w<", "<C-w><", { desc = "[W]indow decrease width" })

-- [[ Tab management ]]
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "[T]ab close [O]thers" })
vim.keymap.set("n", "<leader>t]", "<cmd>tabnext<CR>", { desc = "[T]ab next" })
vim.keymap.set("n", "<leader>t[", "<cmd>tabprev<CR>", { desc = "[T]ab previous" })
vim.keymap.set("n", "<leader>tl", "<cmd>tablast<CR>", { desc = "[T]ab [L]ast" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabfirst<CR>", { desc = "[T]ab [F]irst" })
