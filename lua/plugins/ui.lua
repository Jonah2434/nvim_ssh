return {
  -- Catppuccin Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          which_key = true,
          lsp_trouble = true,
          native_lsp = {
            enabled = false,
          },
        },
      })
      -- Set colorscheme but don't override user's choice if already set
      local current = vim.g.colors_name
      if not current then
        vim.cmd.colorscheme "catppuccin-mocha"
      end
    end,
  },

  -- Theme-Abhängigkeiten
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
          },
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      theme = "wave",
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      variant = "main",
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
    end,
  },
  
  -- NEUE THEMES HIER EINGEFÜGT
  
  -- Dracula Theme
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
      require("dracula").setup({
        -- Optionale Konfiguration
        colors = {
          -- Du kannst hier Farben überschreiben
        },
        transparent_bg = false,
        italic_comment = true,
      })
    end,
  },

  -- Nord Theme
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true
    end,
  },

  -- Onedark Theme
  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "dark", -- Default, dark, darker, cool, deep, warm, warmer
        transparent = false,
      })
    end,
  },

  -- Material Theme
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      vim.g.material_style = "deep ocean" -- oceanic, deep ocean, palenight, lighter, darker
      require("material").setup({
        contrast = {
          terminal = false,
          sidebars = false,
          floating_windows = false,
          cursor_line = false,
          non_current_windows = false,
        },
      })
    end,
  },

  -- Everforest Theme
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_background = "medium" -- soft, medium, hard
      vim.g.everforest_better_performance = 1
    end,
  },
  
  -- Solarized Theme
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    config = function()
      require("solarized").setup({
        styles = {
          comments = { italic = true },
          functions = { bold = true },
        },
        transparent = false,
      })
    end,
  },
  
  -- Monokai Pro Theme
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    config = function()
      require("monokai-pro").setup({
        filter = "pro", -- classic, octagon, pro, machine, ristretto, spectrum
        background_clear = {}, -- list of filetypes where background should be cleared
        transparent_background = false,
        italic_comments = true,
      })
    end,
  },

-- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local function get_filename()
        local listed_buffers = vim.tbl_filter(function(bufnr)
          return vim.api.nvim_buf_get_option(bufnr, "buflisted")
            and vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "nofile"
            and vim.api.nvim_buf_get_option(bufnr, "filetype") ~= "alpha"
        end, vim.api.nvim_list_bufs())
        if #listed_buffers <= 1 then
          return "" -- Kein Dateiname, wenn nur ein Buffer geöffnet ist
        else
          return vim.fn.expand("%:p") -- Voller Pfad des Dateinamens
        end
      end

      return {
        options = {
          theme = "auto", -- Automatisch das aktuelle Theme verwenden
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            { "diff", colored = true },
            "diagnostics",
          },
          lualine_c = {
            { get_filename },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree", "toggleterm", "quickfix" },
      }
    end,
  },

  -- Dateisymbole
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Indentierungslinien
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      enabled = false,
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
        },
      },
    },
  },

  -- Startseite
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        return "jonsellschopf@hopper.de  "
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true
      })
    end,
  },
}

