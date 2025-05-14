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
  
  -- Server-Konfiguration
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
  end

  -- Mason setup
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
  
  -- Standard-Server
  local servers = {
    "lua_ls",
    "ts_ls",
    "html",
    "cssls", 
    "jsonls",
    "pyright",
    "bashls"
  }
  
  -- Korrekte Konfiguration für mason-lspconfig
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    automatic_enable = false,
  })
  
  -- Server-Konfiguration für jeden Sprachserver
  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
  
  -- Hinweis: Emmet-language-server wurde entfernt, da er nicht installiert ist.
  -- Verwende stattdessen :MasonInstall emmet-language-server, um ihn zu installieren.

  local cmp = require("cmp")
  local luasnip = require("luasnip")
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

  vim.keymap.set("n", "<leader>lj", ":set filetype=javascript<CR>", { desc = "Filetype auf JS setzen" })
  vim.keymap.set("n", "<leader>lh", ":set filetype=html<CR>", { desc = "Filetype auf HTML zurück" })

  vim.g.indentLine_enabled = 0
  vim.g.indent_blankline_enabled = false
end

return M  

