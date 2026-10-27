{
  config,
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    claude-code = {
      inherit (config.ai.claude-code) enable;
      package = pkgs.vimPlugins.claude-code-nvim.overrideAttrs (_oldAttrs: {
        patches = [
          ./claude-code_unlist-buffer.patch
        ];
      });

      lazyLoad.enable = true;
      lazyLoad.settings.cmd = [
        "ClaudeCode"
        "ClaudeCodeContinue"
        "ClaudeCodeResume"
        "ClaudeCodeVerbose"
      ];

      settings = {
        window = {
          # A position containing "split" is run verbatim, so this opens a tab; the
          # full ratio stops the plugin's post-split resize from shrinking it.
          split_ratio = 1.0;
          position = "tab split";
          enter_insert = true;
          hide_numbers = true;
          hide_signcolumn = true;
        };
        refresh = {
          enable = true;
          updatetime = 100;
          timer_interval = 1000;
          show_notifications = true;
        };
        git = {
          use_git_root = true;
        };
        command = "claude";
        keymaps = {
          toggle = {
            normal = "<C-;>";
            terminal = "<C-;>";
          };
          window_navigation = true;
          scrolling = true;
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.claude-code.enable [
      {
        __unkeyed-1 = "<leader>ac";
        group = "Claude Code";
        icon = "";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.claude-code.enable [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-:>";
      action.__raw = ''
        function()
          local function is_claude(buf)
            return vim.bo[buf].buftype == "terminal"
              and vim.api.nvim_buf_get_name(buf):match("claude%-code[^/]*$") ~= nil
          end
          if is_claude(0) then
            if vim.fn.tabpagenr("#") > 0 then
              vim.cmd("tabnext #")
            end
            return
          end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if is_claude(vim.api.nvim_win_get_buf(win)) then
              vim.api.nvim_set_current_win(win)
              vim.cmd("startinsert")
              return
            end
          end
          vim.cmd("ClaudeCode")
        end
      '';
      options.desc = "Switch to/from Claude";
    }
    {
      key = "<leader>act";
      action = "<cmd>ClaudeCode<CR>";
      options.desc = "Toggle Claude";
    }
    {
      key = "<leader>acc";
      action = "<cmd>ClaudeCodeContinue<CR>";
      options.desc = "Continue Claude";
    }
    {
      key = "<leader>acr";
      action = "<cmd>ClaudeCodeResume<CR>";
      options.desc = "Resume Claude";
    }
    {
      key = "<leader>acv";
      action = "<cmd>ClaudeCodeVerbose<CR>";
      options.desc = "Verbose Claude";
    }
  ];
}
