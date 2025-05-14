-- Core Initialisierung

-- Globale UI Einstellungen
local function setup_ui()
  -- Deaktiviere alle UI-Elemente, die die Zeilennummern beeinflussen können
  vim.opt.signcolumn = "no"
  
  -- Zeilennummern aktivieren
  vim.opt.number = true
  vim.opt.relativenumber = false
  
  -- Indentation/Linien deaktivieren
  vim.g.indentLine_enabled = 0
  vim.g.indent_blankline_enabled = false
  
  -- Gitsigns anpassen
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.opt.signcolumn = "no"
    end,
  })
end

setup_ui() 

pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]]], "%s+", "") 
