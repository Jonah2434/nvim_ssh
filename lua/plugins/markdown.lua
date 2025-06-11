return {
  -- Das BESTE Markdown-Preview Plugin für Editor
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup({
        -- 🚀 Preview-Einstellungen - AUCH im Insert-Modus!
        preview = {
          modes = { "n", "no", "c", "i" }, -- ✅ "i" für Insert-Modus hinzugefügt
          hybrid_modes = { "n", "i" },     -- ✅ Insert-Modus als Hybrid-Modus

          callbacks = {
            on_enable = function(_, win)
              vim.wo[win].conceallevel = 2;
              vim.wo[win].concealcursor = ""; -- ✅ Leerer String zeigt auch im Insert-Modus
            end
          }
        },

        markdown = {
          -- 📝 Text-Formatierung (Emphasis)
          emphasis = {
            enable = true,

            bold = {
              hl = "MarkviewBold"
            },
            italic = {
              hl = "MarkviewItalic"
            },
            bold_italic = {
              hl = "MarkviewBoldItalic"
            },
            strikethrough = {
              hl = "MarkviewStrikethrough"
            }
          },

          -- 🌙 ÜBERSCHRIFTEN - Catppuccin Farben DIREKT hier
          headings = {
            enable = true,
            shift_width = 0,

            heading_1 = {
              style = "label",
              hl = "MarkviewHeading1",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            },
            heading_2 = {
              style = "label",
              hl = "MarkviewHeading2",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            },
            heading_3 = {
              style = "label",
              hl = "MarkviewHeading3",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            },
            heading_4 = {
              style = "label",
              hl = "MarkviewHeading4",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            },
            heading_5 = {
              style = "label",
              hl = "MarkviewHeading5",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            },
            heading_6 = {
              style = "label",
              hl = "MarkviewHeading6",
              icon = "",
              corner_left = "",
              corner_right = "",
              padding_left = " ",
              padding_right = " "
            }
          },

          -- 🔥 Horizontale Linien
          horizontal_rules = {
            enable = true,
            parts = {
              {
                type = "repeating",
                text = "●",
                repeat_amount = function()
                  return math.floor(vim.o.columns / 3)
                end,
                hl = "MarkviewHorizontalRule"
              }
            }
          },

          -- 📋 Listen
          list_items = {
            enable = true,
            shift_width = 2,

            marker_minus = {
              text = "●",
              hl = "MarkviewListItemMinus"
            },
            marker_plus = {
              text = "○",
              hl = "MarkviewListItemPlus"
            },
            marker_star = {
              text = "◉",
              hl = "MarkviewListItemStar"
            },
            marker_dot = {
              text = "◦",
              hl = "MarkviewListItemDot"
            }
          },

          -- 🔢 Block Quotes
          block_quotes = {
            enable = true,
            default = {
              border = "▎",
              border_hl = "MarkviewBlockQuoteBorder"
            }
          },

          -- 📊 Tabellen
          tables = {
            enable = true,
            use_virt_lines = false,

            text = {
              corner_tl = "╭",
              corner_tr = "╮",
              corner_bl = "╰",
              corner_br = "╯",
              corner_il = "├",
              corner_ir = "┤",
              corner_it = "┬",
              corner_ib = "┴",
              corner_im = "┼",
              top = "─",
              bottom = "─",
              left = "│",
              right = "│",
              header_sep = "─",
              row_sep = "─",
              filler = " "
            },

            hl = {
              header = "MarkviewTableHeader",
              row = "MarkviewTableRow",
              border = "MarkviewTableBorder",
              col = "MarkviewTableCol"
            }
          }
        },

        -- 💻 Code Blöcke
        code_blocks = {
          enable = true,
          style = "simple",
          pad_amount = 0,
          sign = false,
          border_hl = "MarkviewCode",
          info_hl = "MarkviewCodeInfo"
        },

        -- 🔤 Inline Code
        inline_codes = {
          enable = true,
          corner_left = "",
          corner_right = "",
          padding_left = "",
          padding_right = "",
          hl = "MarkviewInlineCode"
        },

        -- ✅ Checkboxen
        checkboxes = {
          enable = true,
          checked = {
            text = "",
            hl = "MarkviewCheckboxChecked"
          },
          unchecked = {
            text = "",
            hl = "MarkviewCheckboxUnchecked"
          },
          pending = {
            text = "",
            hl = "MarkviewCheckboxPending"
          }
        },

        -- 🔗 Links
        links = {
          enable = true,

          hyperlinks = {
            icon = " ",
            hl = "MarkviewHyperlink"
          },

          images = {
            icon = " ",
            hl = "MarkviewImageLink"
          },

          emails = {
            icon = " ",
            hl = "MarkviewEmail"
          }
        },

        -- 🏷️ HTML Tags
        html = {
          enable = true,
          tags = {
            enable = true,
            default = {
              conceal = true
            }
          }
        }
      })

      -- 🌙 CATPPUCCIN-FARBEN sofort nach Setup setzen
      vim.defer_fn(function()
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
      end, 100)
    end
  },

  -- Tabellen-Plugin
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    config = function()
      vim.g.table_mode_corner = "+"
      vim.g.table_mode_corner_corner = "+"
      vim.g.table_mode_header_fillchar = "="
      vim.g.table_mode_fillchar = "-"
      vim.g.table_mode_separator = "|"
      vim.g.table_mode_auto_align = 1
      vim.g.table_mode_update_time = 300
    end,
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>",  desc = "Toggle Table Mode" },
      { "<leader>tt", "<cmd>Tableize<cr>",         desc = "Tableize" },
      { "<leader>tr", "<cmd>TableModeRealign<cr>", desc = "Realign Table" }
    }
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end
  }
}
