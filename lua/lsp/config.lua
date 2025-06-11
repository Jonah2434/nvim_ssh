local M = {}

function M.setup()
  require("neodev").setup()
  require("lspsaga").setup({
    ui = { border = "rounded" },
  })

  -- Deaktiviere alle vertikalen Indentierungs-Linien
  vim.g.indentLine_enabled = 0
  vim.g.indent_blankline_enabled = false

  -- Zeilennummern-Konfiguration
  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.signcolumn = "no"

  -- Überprüfe, ob das ibl-Modul verfügbar ist und deaktiviere es gegebenenfalls
  local has_ibl, ibl = pcall(require, "ibl")
  if has_ibl then
    ibl.setup { enabled = false }
  end

  local lspconfig = require("lspconfig")
  local servers = {
    "lua_ls", "ts_ls", "html", "cssls", "jsonls", "pyright", "bashls", "sqlls"
  }

  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
  })

  local cmp = require("cmp")
  local luasnip = require("luasnip")
  
  -- SQL-Snippets für Datentypen
  local has_luasnip, ls = pcall(require, "luasnip")
  if has_luasnip then
    ls.add_snippets("sql", {
      ls.snippet("int", { ls.text_node("INT") }),
      ls.snippet("integer", { ls.text_node("INTEGER") }),
      ls.snippet("varchar", { 
        ls.text_node("VARCHAR("), 
        ls.insert_node(1, "255"), 
        ls.text_node(")") 
      }),
      ls.snippet("char", { 
        ls.text_node("CHAR("), 
        ls.insert_node(1, "1"), 
        ls.text_node(")") 
      }),
      ls.snippet("text", { ls.text_node("TEXT") }),
      ls.snippet("decimal", { 
        ls.text_node("DECIMAL("), 
        ls.insert_node(1, "10"), 
        ls.text_node(","), 
        ls.insert_node(2, "2"), 
        ls.text_node(")") 
      }),
      ls.snippet("float", { ls.text_node("FLOAT") }),
      ls.snippet("double", { ls.text_node("DOUBLE") }),
      ls.snippet("datetime", { ls.text_node("DATETIME") }),
      ls.snippet("timestamp", { ls.text_node("TIMESTAMP") }),
      ls.snippet("date", { ls.text_node("DATE") }),
      ls.snippet("time", { ls.text_node("TIME") }),
      ls.snippet("boolean", { ls.text_node("BOOLEAN") }),
      ls.snippet("bool", { ls.text_node("BOOL") }),
      ls.snippet("tinyint", { ls.text_node("TINYINT") }),
      ls.snippet("smallint", { ls.text_node("SMALLINT") }),
      ls.snippet("mediumint", { ls.text_node("MEDIUMINT") }),
      ls.snippet("bigint", { ls.text_node("BIGINT") }),
      ls.snippet("longtext", { ls.text_node("LONGTEXT") }),
      ls.snippet("mediumtext", { ls.text_node("MEDIUMTEXT") }),
      ls.snippet("tinytext", { ls.text_node("TINYTEXT") }),
      ls.snippet("blob", { ls.text_node("BLOB") }),
      ls.snippet("json", { ls.text_node("JSON") }),
      ls.snippet("year", { ls.text_node("YEAR") }),
    })
  end

  require('nvim-autopairs').setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {},
    ignored_next_char = [=[[%w%%%'%["%.%`%$]]=],
    enable_check_bracket_line = false,
    enable_moveright = true,
    disable_in_macro = true,
    disable_in_visualblock = true,
    map_cr = true,
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
    pairs_map = {
      ["("] = ")",
      ["["] = "]",
      ['"'] = '"',
    },
  })
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
      { name = "luasnip" },
    }),
    experimental = {
      ghost_text = true,
    },
  })

  -- SQL-spezifische nvim-cmp Konfiguration
  cmp.setup.filetype('sql', {
    sources = cmp.config.sources({
      { name = "luasnip", priority = 1000 },
      { name = "nvim_lsp", priority = 900 },
      { name = "buffer", 
        priority = 800,
        keyword_length = 2,
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
      { name = "path", priority = 300 },
    }),
    formatting = {
      format = function(entry, vim_item)
        -- Icons für verschiedene SQL-Elemente
        local kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        }
        
        -- Spezielle Icons für SQL-Datentypen
        if entry.source.name == "luasnip" then
          vim_item.kind = " Snippet"
        elseif vim_item.word and vim_item.word:match("^[A-Z]+$") then -- SQL Keywords in Großbuchstaben
          vim_item.kind = "󰌋 Keyword"
        end
        
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)
        return vim_item
      end,
    },
    completion = {
      keyword_length = 2,
    },
    matching = {
      disallow_fuzzy_matching = false,
      disallow_fullfuzzy_matching = false,
      disallow_partial_fuzzy_matching = false,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
    },
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local on_attach = function(client, bufnr)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    bufmap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Gehe zu Definition")
    bufmap("n", "gr", "<cmd>Lspsaga finder<CR>", "Referenzen finden")
    bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Dokumentation")
    bufmap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Umbenennen")
    bufmap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Aktion")
    
    -- Debug-Info für LSP
    print("LSP attached: " .. client.name .. " to buffer " .. bufnr)
  end

  -- Vereinfachte LSP-Konfiguration
  for _, server in ipairs(servers) do
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    
    -- Erweiterte Konfiguration für sqlls
    if server == "sqlls" then
      opts.single_file_support = true
      opts.filetypes = { "sql" }
      opts.settings = {
        sqlLanguageServer = {
          lint = {
            rules = {}
          }
        }
      }
      -- Debug für SQL LSP
      opts.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        print("SQL LSP connected to buffer " .. bufnr)
        
        -- SQL-spezifische LSP-Highlights beibehalten
        vim.api.nvim_create_autocmd("LspAttach", {
          buffer = bufnr,
          callback = function()
            -- Setze LSP-Highlights NACH unserem Custom Highlighting
            vim.defer_fn(function()
              -- LSP semantic tokens aktivieren
              if client.server_capabilities.semanticTokensProvider then
                vim.lsp.semantic_tokens.start(bufnr, client.id)
              end
            end, 100)
          end,
        })
      end
    end
    
    lspconfig[server].setup(opts)
  end

  -- SQL-Keywords für bessere Completion
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
      -- SQL-spezifische Buffer-Einstellungen
      vim.opt_local.iskeyword:append("_")
      vim.opt_local.complete:append("k")
      
      local keywords = {
        "INT", "INTEGER", "VARCHAR", "CHAR", "TEXT", "DECIMAL", "FLOAT", "DOUBLE",
        "DATETIME", "TIMESTAMP", "DATE", "TIME", "BOOLEAN", "BOOL", "TINYINT",
        "SMALLINT", "MEDIUMINT", "BIGINT", "LONGTEXT", "MEDIUMTEXT", "TINYTEXT",
        "BINARY", "VARBINARY", "BLOB", "LONGBLOB", "MEDIUMBLOB", "TINYBLOB",
        "JSON", "ENUM", "SET", "YEAR", "PRIMARY", "KEY", "FOREIGN", "UNIQUE",
        "NOT", "NULL", "DEFAULT", "AUTO_INCREMENT", "UNSIGNED", "ZEROFILL",
        "SELECT", "FROM", "WHERE", "INSERT", "UPDATE", "DELETE", "CREATE", "ALTER", "DROP"
      }
      
      -- Setze Keywords direkt in die Buffer-Variable für completion
      vim.b.sql_keywords = table.concat(keywords, "\n")
    end,
  })

  -- SQL Dictionary Konfiguration
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
      -- Erstelle temporäre Dictionary-Datei wenn sie nicht existiert
      local dict_path = vim.fn.stdpath("cache") .. "/sql_dict.txt"
      local dict_file = io.open(dict_path, "r")
      if not dict_file then
        dict_file = io.open(dict_path, "w")
        if dict_file then
          local sql_dict_content = {
            "INT", "INTEGER", "VARCHAR", "CHAR", "TEXT", "DECIMAL", "FLOAT", "DOUBLE",
            "DATETIME", "TIMESTAMP", "DATE", "TIME", "BOOLEAN", "BOOL", "TINYINT",
            "SMALLINT", "MEDIUMINT", "BIGINT", "LONGTEXT", "MEDIUMTEXT", "TINYTEXT",
            "BINARY", "VARBINARY", "BLOB", "LONGBLOB", "MEDIUMBLOB", "TINYBLOB",
            "JSON", "ENUM", "SET", "YEAR", "PRIMARY", "KEY", "FOREIGN", "UNIQUE",
            "NOT", "NULL", "DEFAULT", "AUTO_INCREMENT", "UNSIGNED", "ZEROFILL"
          }
          for _, word in ipairs(sql_dict_content) do
            dict_file:write(word .. "\n")
          end
          dict_file:close()
        end
      else
        dict_file:close()
      end
      
      -- Setze Dictionary für Completion
      vim.opt_local.dictionary:append(dict_path)
      vim.opt_local.complete:append("k")
    end,
  })

  -- SQL Syntax Highlighting für Catppuccin (LSP-kompatibel)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
      -- Warte kurz, damit LSP zuerst laden kann
      vim.defer_fn(function()
        -- Catppuccin Farben für SQL
        local catppuccin_colors = {
          rosewater = "#f5e0dc",
          flamingo = "#f2cdcd", 
          pink = "#f5c2e7",
          mauve = "#cba6f7",
          red = "#f38ba8",
          maroon = "#eba0ac",
          peach = "#fab387",
          yellow = "#f9e2af",
          green = "#a6e3a1",
          teal = "#94e2d5",
          sky = "#89dceb",
          sapphire = "#74c7ec",
          blue = "#89b4fa",
          lavender = "#b4befe",
        }

        -- SQL Keywords Highlighting (niedrigere Priorität als LSP)
        vim.api.nvim_set_hl(0, "sqlKeyword", { fg = catppuccin_colors.mauve, bold = true })
        vim.api.nvim_set_hl(0, "sqlType", { fg = catppuccin_colors.yellow, bold = true })
        vim.api.nvim_set_hl(0, "sqlFunction", { fg = catppuccin_colors.blue })
        vim.api.nvim_set_hl(0, "sqlOperator", { fg = catppuccin_colors.sky })
        vim.api.nvim_set_hl(0, "sqlString", { fg = catppuccin_colors.green })
        vim.api.nvim_set_hl(0, "sqlNumber", { fg = catppuccin_colors.peach })
        vim.api.nvim_set_hl(0, "sqlComment", { fg = catppuccin_colors.lavender, italic = true })
        
        -- LSP Semantic Highlights überschreiben/ergänzen
        vim.api.nvim_set_hl(0, "@lsp.type.keyword.sql", { fg = catppuccin_colors.mauve, bold = true })
        vim.api.nvim_set_hl(0, "@lsp.type.type.sql", { fg = catppuccin_colors.yellow, bold = true })
        vim.api.nvim_set_hl(0, "@lsp.type.function.sql", { fg = catppuccin_colors.blue })
        vim.api.nvim_set_hl(0, "@lsp.type.operator.sql", { fg = catppuccin_colors.sky })
        
        -- Sichere SQL Syntax-Matches (niedrigere Priorität)
        pcall(vim.fn.matchadd, "sqlKeyword", "\\<\\(SELECT\\|FROM\\|WHERE\\|INSERT\\|UPDATE\\|DELETE\\|CREATE\\|ALTER\\|DROP\\|INDEX\\|TABLE\\|DATABASE\\|SCHEMA\\|VIEW\\|TRIGGER\\|PROCEDURE\\|FUNCTION\\|BEGIN\\|END\\|IF\\|ELSE\\|WHILE\\|FOR\\|LOOP\\|RETURN\\|DECLARE\\|SET\\|EXEC\\|EXECUTE\\)\\>", 10)
        
        pcall(vim.fn.matchadd, "sqlType", "\\<\\(INT\\|INTEGER\\|VARCHAR\\|CHAR\\|TEXT\\|DECIMAL\\|FLOAT\\|DOUBLE\\|DATETIME\\|TIMESTAMP\\|DATE\\|TIME\\|BOOLEAN\\|BOOL\\|TINYINT\\|SMALLINT\\|MEDIUMINT\\|BIGINT\\|LONGTEXT\\|MEDIUMTEXT\\|TINYTEXT\\|BINARY\\|VARBINARY\\|BLOB\\|LONGBLOB\\|MEDIUMBLOB\\|TINYBLOB\\|JSON\\|ENUM\\|SET\\|YEAR\\)\\>", 10)
        
        pcall(vim.fn.matchadd, "sqlKeyword", "\\<\\(PRIMARY\\|KEY\\|FOREIGN\\|UNIQUE\\|NOT\\|NULL\\|DEFAULT\\|AUTO_INCREMENT\\|UNSIGNED\\|ZEROFILL\\|CONSTRAINT\\|REFERENCES\\|CASCADE\\|RESTRICT\\|ON\\|UPDATE\\|DELETE\\)\\>", 10)
        
        pcall(vim.fn.matchadd, "sqlFunction", "\\<\\(COUNT\\|SUM\\|AVG\\|MIN\\|MAX\\|UPPER\\|LOWER\\|LENGTH\\|SUBSTRING\\|CONCAT\\|NOW\\|DATE\\|YEAR\\|MONTH\\|DAY\\|HOUR\\|MINUTE\\|SECOND\\)\\>", 10)
        
        -- Operatoren einzeln hinzufügen
        pcall(vim.fn.matchadd, "sqlOperator", "\\<\\(LIKE\\|IN\\|BETWEEN\\|AND\\|OR\\|NOT\\|IS\\|EXISTS\\|ANY\\|ALL\\|UNION\\|JOIN\\|INNER\\|LEFT\\|RIGHT\\|FULL\\|OUTER\\|CROSS\\)\\>", 10)
        pcall(vim.fn.matchadd, "sqlOperator", "!=", 10)
        pcall(vim.fn.matchadd, "sqlOperator", "<>", 10)
        pcall(vim.fn.matchadd, "sqlOperator", "<=", 10)
        pcall(vim.fn.matchadd, "sqlOperator", ">=", 10)
      end, 500) -- Warte 500ms damit LSP zuerst lädt
    end,
  })

  -- Verbesserte nvim-cmp Highlights für SQL
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- CMP Menu Farben für SQL
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#f5c2e7", bg = "NONE" })  -- Pink für Snippets
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#cba6f7", bg = "NONE" })  -- Mauve für Keywords
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#f9e2af", bg = "NONE" })     -- Yellow für Types
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#89b4fa", bg = "NONE" })   -- Blue für Functions
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#94e2d5", bg = "NONE" }) -- Teal für Variables
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#fab387", bg = "NONE" })    -- Peach für Classes
    end,
  })

  -- Treesitter SQL Highlighting (falls vorhanden)
  local has_treesitter, ts_configs = pcall(require, "nvim-treesitter.configs")
  if has_treesitter then
    ts_configs.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "sql" },
      },
      ensure_installed = { "sql" },
    })
  end

  -- Debug-Kommando für LSP Status
  vim.api.nvim_create_user_command("SqlLspInfo", function()
    local clients = vim.lsp.get_active_clients({ name = "sqlls" })
    if #clients > 0 then
      print("SQL LSP aktiv: " .. #clients .. " Client(s)")
      for _, client in ipairs(clients) do
        print("  - Client ID: " .. client.id .. ", Buffer: " .. vim.api.nvim_get_current_buf())
      end
    else
      print("SQL LSP nicht aktiv")
    end
  end, {})

  vim.keymap.set("n", "<leader>lj", ":set filetype=javascript<CR>", { desc = "Filetype auf JS setzen" })
  vim.keymap.set("n", "<leader>lh", ":set filetype=html<CR>", { desc = "Filetype auf HTML zurück" })

  vim.g.indentLine_enabled = 0
  vim.g.indent_blankline_enabled = false
end

return M
