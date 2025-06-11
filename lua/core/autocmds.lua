-- 🌙 CATPPUCCIN-FARBEN für Markview - GLOBAL verfügbar
_G.set_markview_colors = function()
  -- 🌙 ÜBERSCHRIFTEN - Moderne Catppuccin-Farben
  vim.api.nvim_set_hl(0, "MarkviewHeading1", { 
    fg = "#cba6f7", -- Mauve (Catppuccin)
    bold = true, 
    italic = true
  })
  
  vim.api.nvim_set_hl(0, "MarkviewHeading2", { 
    fg = "#89b4fa", -- Blue (Catppuccin)
    bold = true, 
    italic = true 
  })
  
  vim.api.nvim_set_hl(0, "MarkviewHeading3", { 
    fg = "#74c7ec", -- Sky (Catppuccin)
    bold = true 
  })
  
  vim.api.nvim_set_hl(0, "MarkviewHeading4", { 
    fg = "#94e2d5", -- Teal (Catppuccin)
    italic = true 
  })
  
  vim.api.nvim_set_hl(0, "MarkviewHeading5", { 
    fg = "#a6e3a1" -- Green (Catppuccin)
  })
  
  vim.api.nvim_set_hl(0, "MarkviewHeading6", { 
    fg = "#f38ba8" -- Pink (Catppuccin)
  })
  
  -- 📝 TEXT-FORMATIERUNG - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewBold", { 
    fg = "#fab387", -- Peach (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewItalic", { 
    fg = "#89dceb", -- Sapphire (Catppuccin)
    italic = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewBoldItalic", { 
    fg = "#cba6f7", -- Mauve (Catppuccin)
    bold = true, 
    italic = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewStrikethrough", { 
    fg = "#6c7086", -- Overlay0 (Catppuccin)
    strikethrough = true 
  })
  
  -- 💻 CODE - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewCode", { 
    fg = "#cdd6f4", -- Text (Catppuccin)
    italic = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewInlineCode", { 
    fg = "#a6e3a1", -- Green (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewCodeInfo", { 
    fg = "#b4befe", -- Lavender (Catppuccin)
    italic = true 
  })
  
  -- 🔴 LISTEN-MARKER - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { 
    fg = "#f38ba8", -- Pink (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewListItemPlus", { 
    fg = "#94e2d5", -- Teal (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewListItemStar", { 
    fg = "#f9e2af", -- Yellow (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewListItemDot", { 
    fg = "#cba6f7", -- Mauve (Catppuccin)
    bold = true 
  })
  
  -- 🔥 Horizontale Linien
  vim.api.nvim_set_hl(0, "MarkviewHorizontalRule", { 
    fg = "#89b4fa", -- Blue (Catppuccin)
    bold = true 
  })
  
  -- ✅ Checkboxen - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewCheckboxChecked", { 
    fg = "#a6e3a1", -- Green (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewCheckboxUnchecked", { 
    fg = "#6c7086", -- Overlay0 (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewCheckboxPending", { 
    fg = "#f9e2af", -- Yellow (Catppuccin)
    bold = true 
  })
  
  -- 💬 Block Quotes
  vim.api.nvim_set_hl(0, "MarkviewBlockQuoteBorder", { 
    fg = "#b4befe", -- Lavender (Catppuccin)
    bold = true 
  })
  
  -- 📊 Tabellen - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewTableHeader", { 
    fg = "#cba6f7", -- Mauve (Catppuccin)
    bold = true, 
    italic = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewTableRow", { 
    fg = "#cdd6f4" -- Text (Catppuccin)
  })
  vim.api.nvim_set_hl(0, "MarkviewTableBorder", { 
    fg = "#6c7086", -- Overlay0 (Catppuccin)
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewTableCol", { 
    fg = "#74c7ec" -- Sky (Catppuccin)
  })
  
  -- 🔗 Links - Catppuccin Stil
  vim.api.nvim_set_hl(0, "MarkviewHyperlink", { 
    fg = "#89b4fa", -- Blue (Catppuccin)
    underline = true, 
    bold = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewImageLink", { 
    fg = "#fab387", -- Peach (Catppuccin)
    italic = true 
  })
  vim.api.nvim_set_hl(0, "MarkviewEmail", { 
    fg = "#a6e3a1", -- Green (Catppuccin)
    underline = true 
  })
  
  print("🌙 Catppuccin Farben für Markview gesetzt!")
end

-- SOFORT beim Start setzen
vim.defer_fn(_G.set_markview_colors, 100)

-- Bei Colorscheme-Änderung
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.defer_fn(_G.set_markview_colors, 50)
  end
})

-- Auto-enable Markview MIT besseren Insert-Modus-Einstellungen
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.cmd("Markview enable")
    
    -- ✅ Optimale Einstellungen für Insert-Modus-Preview
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "" -- ✅ Leerer String für Insert-Modus-Sichtbarkeit
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
    
    -- Farben NACH Markview-Aktivierung setzen
    vim.defer_fn(_G.set_markview_colors, 200)
    vim.defer_fn(_G.set_markview_colors, 500) -- Zweimal für Sicherheit
  end
})

-- 🚀 Bessere Tabellen-Navigation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Tab für nächste Tabellen-Zelle
    vim.keymap.set("i", "<Tab>", function()
      if vim.fn.search("\\%#\\zs|", "cn") > 0 then
        return "<Esc>f|a"
      else
        return "<Tab>"
      end
    end, { expr = true, buffer = true })
    
    -- Shift-Tab für vorherige Tabellen-Zelle  
    vim.keymap.set("i", "<S-Tab>", function()
      if vim.fn.search("|\\ze\\%#", "bcn") > 0 then
        return "<Esc>F|i"
      else
        return "<S-Tab>"
      end
    end, { expr = true, buffer = true })
  end
})

-- 🎯 Markdown Shortcuts
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }
    
    -- Format-Shortcuts
    vim.keymap.set("n", "<leader>mb", "ciw**<C-r>\"**<Esc>", opts)     -- Bold
    vim.keymap.set("n", "<leader>mi", "ciw*<C-r>\"*<Esc>", opts)       -- Italic
    vim.keymap.set("n", "<leader>mc", "ciw`<C-r>\"`<Esc>", opts)       -- Code
    vim.keymap.set("n", "<leader>ms", "ciw~~<C-r>\"~~<Esc>", opts)     -- Strike
    
    -- Visual Mode
    vim.keymap.set("v", "<leader>mb", "c**<C-r>\"**<Esc>", opts)       -- Bold
    vim.keymap.set("v", "<leader>mi", "c*<C-r>\"*<Esc>", opts)         -- Italic
    vim.keymap.set("v", "<leader>mc", "c`<C-r>\"`<Esc>", opts)         -- Code
    vim.keymap.set("v", "<leader>ms", "c~~<C-r>\"~~<Esc>", opts)       -- Strike
    
    -- Überschriften
    vim.keymap.set("n", "<leader>m1", "I# <Esc>", opts)
    vim.keymap.set("n", "<leader>m2", "I## <Esc>", opts)
    vim.keymap.set("n", "<leader>m3", "I### <Esc>", opts)
    vim.keymap.set("n", "<leader>m4", "I#### <Esc>", opts)
    vim.keymap.set("n", "<leader>m5", "I##### <Esc>", opts)
    vim.keymap.set("n", "<leader>m6", "I###### <Esc>", opts)
    
    -- Links
    vim.keymap.set("n", "<leader>ml", "ciw[<C-r>\"]()<Esc>F)i", opts)   -- Link
    vim.keymap.set("v", "<leader>ml", "c[<C-r>\"]()<Esc>F)i", opts)     -- Link
    
    -- 🌙 MANUELLER Farben-Trigger
    vim.keymap.set("n", "<leader>mf", ":lua set_markview_colors()<CR>", opts)  -- f für Farben
  end
})
