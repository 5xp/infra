{ inputs, ... }:
{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        enable = true;
        package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
        defaultEditor = true;

        extraPackages = with pkgs; [
          nixfmt
          nixd
          tinymist
        ];

        themes.vague = ./vague.toml;

        settings = {
          theme = "vague";
          editor = {
            line-number = "relative";
            color-modes = true;
            cursorline = true;
            scrolloff = 10;
            idle-timeout = 500;
            completion-timeout = 5;
            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
            trim-final-newlines = true;
            trim-trailing-whitespace = true;
            scroll-lines = 1;
            cursor-shape = {
              insert = "bar";
              normal = "block";
            };
            lsp = {
              display-inlay-hints = true;
              auto-document-highlight = true;
            };
          };
          keys = {
            normal = {
              tab = "move_parent_node_end";
              S-tab = "move_parent_node_start";
              X = "extend_line_above";
            };
            insert = {
              S-tab = "move_parent_node_start";
            };
            select = {
              tab = "extend_parent_node_end";
              S-tab = "extend_parent_node_start";
              X = "extend_line_above";
            };
          };
        };

        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "nixfmt";
              language-servers = [ "nixd" ];
            }
            {
              name = "typst";
              auto-format = true;
              soft-wrap.enable = true;
              rulers = [ 120 ];
            }
          ];
          language-server = {
            nixd.command = "nixd";
            rust-analyzer.config.check.command = "clippy";
            tinymist.config = {
              formatterMode = "typstyle";
              formatterProseWrap = true;
              formatterPrintWidth = 120;
              lint = {
                enabled = true;
                when = "onType";
              };
            };
          };
        };
      };
    };
}
