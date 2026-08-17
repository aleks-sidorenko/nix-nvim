{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = true;
      };
      fzf-native = {
        enable = true;
      };
      live-grep-args = {
        enable = true;
      };
    };
    settings = {
      defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top";
          };
        };
        sorting_strategy = "ascending";
        # Navigate results with C-j/C-k; C-n/C-p are intentionally disabled.
        mappings = {
          i = {
            "<C-j>".__raw = "require('telescope.actions').move_selection_next";
            "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
            "<C-n>" = false;
            "<C-p>" = false;
            # Splits: C-- horizontal, C-| vertical (Ctrl+Shift+\, delivered as
            # <C-S-Bslash>; the <C-|>/<C-Bar> notations don't reach Neovim).
            # C-v/C-x (telescope defaults) are retained — these are additive.
            "<C-->".__raw = "require('telescope.actions').select_horizontal";
            "<C-S-Bslash>".__raw = "require('telescope.actions').select_vertical";
          };
          n = {
            "<C-j>".__raw = "require('telescope.actions').move_selection_next";
            "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
            "<C-n>" = false;
            "<C-p>" = false;
            # Splits mirror insert mode: C-- horizontal, C-| vertical.
            "<C-->".__raw = "require('telescope.actions').select_horizontal";
            "<C-S-Bslash>".__raw = "require('telescope.actions').select_vertical";
          };
        };
      };
      pickers = {
        find_files = {
          # fd respects .gitignore by default; --hidden surfaces dotfiles,
          # --exclude .git keeps the git internals out.
          find_command = [
            "fd"
            "--type"
            "f"
            "--hidden"
            "--strip-cwd-prefix"
            "--exclude"
            ".git"
          ];
        };
        colorscheme = {
          enable_preview = true;
        };
      };
    };
    keymaps = {
      "<leader><space>" = {
        action = "find_files";
        options = {
          desc = "Find project files";
        };
      };
      "<leader>:" = {
        action = "command_history";
        options = {
          desc = "Command History";
        };
      };
      "<leader>b" = {
        action = "buffers";
        options = {
          desc = "+buffer";
        };
      };
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "Find project files";
        };
      };
      "<leader>fR" = {
        action = "resume";
        options = {
          desc = "Resume";
        };
      };
      "<leader>fg" = {
        action = "oldfiles";
        options = {
          desc = "Recent";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Buffers";
        };
      };
      "<C-p>" = {
        action = "git_files";
        options = {
          desc = "Search git files";
        };
      };
      "<leader>gc" = {
        action = "git_commits";
        options = {
          desc = "Commits";
        };
      };
      "<leader>gs" = {
        action = "git_status";
        options = {
          desc = "Status";
        };
      };
      "<leader>sa" = {
        action = "autocommands";
        options = {
          desc = "Auto Commands";
        };
      };
      "<leader>sb" = {
        action = "current_buffer_fuzzy_find";
        options = {
          desc = "Buffer";
        };
      };
      "<leader>sc" = {
        action = "command_history";
        options = {
          desc = "Command History";
        };
      };
      "<leader>sC" = {
        action = "commands";
        options = {
          desc = "Commands";
        };
      };
      "<leader>sD" = {
        action = "diagnostics";
        options = {
          desc = "Workspace diagnostics";
        };
      };
      "<leader>sh" = {
        action = "help_tags";
        options = {
          desc = "Help pages";
        };
      };
      "<leader>sH" = {
        action = "highlights";
        options = {
          desc = "Search Highlight Groups";
        };
      };
      "<leader>sk" = {
        action = "keymaps";
        options = {
          desc = "Keymaps";
        };
      };
      "<leader>sM" = {
        action = "man_pages";
        options = {
          desc = "Man pages";
        };
      };
      "<leader>sm" = {
        action = "marks";
        options = {
          desc = "Jump to Mark";
        };
      };
      "<leader>so" = {
        action = "vim_options";
        options = {
          desc = "Options";
        };
      };
      "<leader>sR" = {
        action = "resume";
        options = {
          desc = "Resume";
        };
      };
      "<leader>uC" = {
        action = "colorscheme";
        options = {
          desc = "Colorscheme preview";
        };
      };
    };
  };
  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
  keymaps = [
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>";
      options = {
        desc = "Grep (args)";
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>";
      options = {
        desc = "Find text (args)";
      };
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>";
      options = {
        desc = "Grep word under cursor";
      };
    }
    {
      mode = "x";
      key = "<leader>fw";
      action = "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>";
      options = {
        desc = "Grep selection";
      };
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>Telescope diagnostics bufnr=0<cr>";
      options = {
        desc = "Document diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Telescope file_browser<cr>";
      options = {
        desc = "File browser";
      };
    }
    {
      mode = "n";
      key = "<leader>fE";
      action = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>";
      options = {
        desc = "File browser";
      };
    }
    {
      mode = "n";
      key = "<leader>fF";
      action = "<cmd>Telescope find_files cwd=%:p:h<cr>";
      options = {
        desc = "Find files (current file dir)";
      };
    }
  ];
}
