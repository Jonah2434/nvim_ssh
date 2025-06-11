return {
  -- Mini-Plugins
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "gza",
          delete = "gzD",
          find = "gzF",
          find_left = "gzL",
          highlight = "gzH",
          replace = "gzR",
          update_n_lines = "gzN",
        },
      })
      require("mini.pairs").setup({})
    end,
  },

  -- Bessere Schriftauswahl
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        prompt_align = "left",
        insert_only = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 0,
          wrap = false,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
        override = function(conf)
          return conf
        end,
        get_config = nil,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        telescope = nil,
        fzf = {
          window = { width = 0.5, height = 0.4 },
        },
        fzf_lua = {
          winopts = { width = 0.5, height = 0.4 },
        },
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = { style = "rounded" },
          buf_options = { swapfile = false, filetype = "DressingSelect" },
          win_options = { winblend = 0 },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = { winblend = 0 },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          override = function(conf)
            return conf
          end,
        },
        format_item_override = {},
        get_config = nil,
      },
    },
  },

  -- Besser UI (Nachrichten in Cmdline, Verlauf verfügbar)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = "notify", -- Popups unten rechts
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      notify = {
        enabled = true,
        view = "notify", -- Popups unten rechts
        level = 3,
        timeout = 3000,
        minimum_width = 10,
      },
      history = {
        view = "split",
        opts = { border = "rounded", title = "Notifications" },
        filter = { any = { { event = "notify" }, { error = true }, { warning = true } } },
      },
      routes = {},
    },
    config = function(_, opts)
      require("noice").setup(opts)
      -- Verlauf leeren beim Verlassen eines Buffers
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          require("noice").cmd("dismiss")
        end,
      })
    end,
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true, -- Aktiviere die Vorschau für Colorschemes
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },

  -- Besser Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "alpha",
            text = "",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Automatisch Bufferline ausblenden, wenn nur ein Buffer geöffnet ist
      vim.api.nvim_create_autocmd({ "BufEnter", "BufDelete", "BufWinEnter" }, {
        callback = function()
          local listed_buffers = vim.tbl_filter(function(bufnr)
            return vim.api.nvim_buf_get_option(bufnr, "buflisted")
                and vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "nofile"
                and vim.api.nvim_buf_get_option(bufnr, "filetype") ~= "alpha"
          end, vim.api.nvim_list_bufs())
          if #listed_buffers <= 1 then
            vim.o.showtabline = 0 -- Bufferline ausblenden
          else
            vim.o.showtabline = 2 -- Bufferline anzeigen
          end
        end,
      })
    end,
  },

  -- Treesitter für bessere Syntax und Einrückung
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "css", "javascript", "lua", "sql" },
        indent = {
          enable = true,
          disable = { "sql" }, -- Deaktiviere Auto-Indent für SQL
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },

  -- Kontextabhängige Kommentare in HTML/CSS/JS
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },

  -- Snippet-Sammlung für HTML/CSS/JS
  {
    "rafamadriz/friendly-snippets",
    event = "VeryLazy",
  },

  -- HTML Formatter (Beispiel: Prettier) - Mit sqlfmt für SQL
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Formatierung vor dem Speichern (optional)
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          html = { "remove_double_angle", "prettier" },
          css = { "prettier" },
          lua = { "stylua" },
          sql = { "sqlfmt" }, -- Verwende sqlfmt von Mason
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          prettier = {
            prepend_args = { "--tab-width", "2", "--single-quote", "false" },
          },
          stylua = {},
          remove_double_angle = {
            -- reiner Lua-Formatter für conform
            format = function(text)
              -- Entferne alle doppelten '<' am Zeilenanfang
              local cleaned = text:gsub("^<<", "<"):gsub("\n<<", "\n<")
              return cleaned
            end,
          },
          -- sqlfmt Konfiguration für kompakte INSERT Statements
          sqlfmt = {
            command = "sqlfmt",
            args = {
              "--print-only",
              "--line-length", "120", -- Längere Zeilen erlauben
              "--dialect", "generic",   -- Generischer SQL-Dialekt
              "-",                      -- Stdin verwenden
            },
            stdin = true,
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = " Format file or range" })
    end,
  },
}
