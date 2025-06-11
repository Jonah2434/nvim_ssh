-- Datei: nvim_neu/lua/core/keymaps.lua
-- Leader-Key setzen
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Allgemeine Keybindings
local map = vim.keymap.set -- Benutze vim.keymap.set für neuere Neovim Versionen
local opts = { noremap = true, silent = true }

-- Normal Mode
map("n", "<leader>w", ":w<CR>", { desc = " Save" })
map("n", "<leader>q", ":q<CR>", { desc = " Quit" })
map("n", "<C-h>", "<C-w>h", { desc = "󰜲 Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "󰜮 Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "󰜰 Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "󰜴 Window Right" })
map("n", "<leader>xn", "<cmd>Noice history<CR>", { desc = " historii Nachrichten-Verlauf" }) -- <<< HINZUGEFÜGT / BESTÄTIGT

-- LSP Keybindings (gruppiert unter <leader>l)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "󰊢 Goto Definition" })
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "󰊢 Goto Declaration" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "󰈇 Goto References" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "󰌵 Hover Info" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "󰑕 LSP Rename" })
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "󰌵 LSP Code Action" })
-- map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = " LSP Format" }) -- Ersetzt durch conform.nvim Keymap in editor.lua
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "󰝒 Previous Diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "󰝓 Next Diagnostic" })
map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "󱐋 Line Diagnostics" })

-- Visual Mode
map("v", "<", "<gv", { desc = "󰉦 Indent Left" })
map("v", ">", ">gv", { desc = "󰉢 Indent Right" })

-- Git Keymaps (unter <leader>g)
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = " LazyGit" })
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = " Git Status" }) -- Fugitive
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = " Git Blame" }) -- Fugitive
-- map("n", "<leader>gl", "<cmd>Git log<CR>", { desc = " Git Log" }) -- Fugitive (optional)
-- map("n", "<leader>gd", "<cmd>Git diff<CR>", { desc = " Git Diff" }) -- Fugitive (optional)
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = " Git Push" }) -- Fugitive
map("n", "<leader>gf", "<cmd>Git pull<CR>", { desc = " Git Pull" }) -- Fugitive

-- Hunk Keymaps (Gitsigns - von plugins/git.lua hierher verschoben zur Übersichtlichkeit, falls gewünscht)
-- Oder belasse sie in der on_attach Funktion in plugins/git.lua
-- map("n", "]c", function() ... end)
-- map("n", "[c", function() ... end)
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = " Stage Hunk" })
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = " Reset Hunk" })
map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = " Stage Selected" })
map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = " Reset Selected" })
map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", { desc = " Stage Buffer" })
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", { desc = " Undo Stage" })
map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", { desc = " Reset Buffer" })
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = " Preview Hunk" })
map("n", "<leader>hb", ":Gitsigns blame_line<CR>", { desc = " Blame Line" }) -- Oder full=true
map("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", { desc = " Toggle Blame" })
map("n", "<leader>hd", ":Gitsigns diffthis<CR>", { desc = " Diff This" })
map("n", "<leader>hD", ":Gitsigns diffthis ~<CR>", { desc = " Diff This ~" })
map("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", { desc = " Toggle Deleted" })

-- Theme Toggle Keymaps
map("n", "<leader>tc", "<cmd>lua require('theme-switcher').telescope_picker()<CR>", { desc = " Theme Preview" })
map("n", "<leader>tl", "<cmd>lua require('theme-switcher').toggle_theme(true)<CR>", { desc = " Toggle Light/Dark" })
map("n", "<leader>td", "<cmd>lua require('theme-switcher').toggle_theme(false)<CR>", { desc = " Toggle Dark" })

-- ChatGPT Keymaps (falls das Plugin aktiv ist)
map("n", "<leader>ca", "<cmd>ChatGPT<CR>", { desc = "ChatGPT prompt window" })
map({ "n", "v" }, "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit code with instruction" })
map({ "n", "v" }, "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Correct grammar" })
map({ "n", "v" }, "<leader>ct", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })

-- Terminal Keymaps (ToggleTerm - von plugins/terminal.lua hierher verschoben zur Übersichtlichkeit, falls gewünscht)
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<CR>", { desc = "Vertical Terminal" })
-- Terminal Mode Mappings (werden in plugins/terminal.lua in der config Funktion gesetzt)
-- map("t", "<esc>", [[<C-\><C-n>]], term_opts)
-- map("t", "<C-h>", [[<C-\><C-n><C-W>h]], term_opts) ... etc

-- Telescope Keymaps (von plugins/explorer.lua hierher verschoben zur Übersichtlichkeit)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Old Files" }) -- Zusätzliches Beispiel

-- Bufferline Keymaps (von plugins/editor.lua)
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- NvimTree Keymap (von plugins/explorer.lua)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Conform Keymap (von plugins/editor.lua)
map({ "n", "v" }, "<leader>lf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, { desc = " Format file or range" })


-- Deutsche Tastatur: Klammern auf Ö und Ä (wie US-Layout)
map("n", "ö", "[", opts)
map("n", "Ö", "{", opts)
map("n", "ä", "]", opts)
map("n", "Ä", "}", opts)
map("v", "ö", "[", opts)
map("v", "Ö", "{", opts)
map("v", "ä", "]", opts)
map("v", "Ä", "}", opts)
map("i", "ö", "[", opts)
map("i", "Ö", "{", opts)
map("i", "ä", "]", opts)
map("i", "Ä", "}", opts)

-- Markdown Toggle
vim.keymap.set("n", "<leader>mp", "<cmd>Markview toggle<cr>", { desc = "Toggle Markdown Preview" })
vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggleAll<cr>", { desc = "Toggle All Markdown Features" })

-- Erweiterte Tabellen-Keybindings in keymaps.lua
vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<cr>", { desc = "󰓫 Toggle Table Mode" })
vim.keymap.set("n", "<leader>tt", "<cmd>Tableize<cr>", { desc = "󰓫 Tableize Selection" })
vim.keymap.set("n", "<leader>tr", "<cmd>TableModeRealign<cr>", { desc = "󰓫 Realign Table" })
vim.keymap.set("n", "<leader>ts", "<cmd>TableSort<cr>", { desc = "󰓫 Sort Table" })
vim.keymap.set("n", "<leader>tdd", "<cmd>TableDeleteRow<cr>", { desc = "󰓫 Delete Row" })
vim.keymap.set("n", "<leader>tdc", "<cmd>TableDeleteColumn<cr>", { desc = "󰓫 Delete Column" })

-- 📝 MARKDOWN FORMATIERUNG Keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local map = vim.keymap.set
    local opts = { buffer = true }
    
    -- Text-Formatierung
    map("v", "<leader>mb", "c**<C-r>\"**<Esc>", vim.tbl_extend("force", opts, { desc = "Make Bold" }))
    map("v", "<leader>mi", "c*<C-r>\"*<Esc>", vim.tbl_extend("force", opts, { desc = "Make Italic" }))
    map("v", "<leader>ms", "c~~<C-r>\"~~<Esc>", vim.tbl_extend("force", opts, { desc = "Make Strikethrough" }))
    map("v", "<leader>mc", "c`<C-r>\"`<Esc>", vim.tbl_extend("force", opts, { desc = "Make Code" }))
    
    -- Schnelle Einfügungen
    map("n", "<leader>m1", "I# <Esc>", vim.tbl_extend("force", opts, { desc = "H1 Heading" }))
    map("n", "<leader>m2", "I## <Esc>", vim.tbl_extend("force", opts, { desc = "H2 Heading" }))
    map("n", "<leader>m3", "I### <Esc>", vim.tbl_extend("force", opts, { desc = "H3 Heading" }))
    map("n", "<leader>m-", "I- <Esc>A", vim.tbl_extend("force", opts, { desc = "List Item" }))
    map("n", "<leader>mx", "I- [ ] <Esc>A", vim.tbl_extend("force", opts, { desc = "Checkbox" }))
    map("n", "<leader>mq", "I> <Esc>A", vim.tbl_extend("force", opts, { desc = "Quote" }))
  end
})
