{ self, inputs, ... }:
{
  flake.modules.nixos.helix =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myHelix
      ];
      environment.variables.EDITOR = "hx";
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.myHelix = inputs.wrapper-modules.wrappers.helix.wrap {
        inherit pkgs;

        runtimePkgs = with pkgs; [
          nixfmt
          nixd
        ];

        themes.vague = builtins.readFile ./vague.toml;

        settings = {
          theme = "vague";
          editor = {
            line-number = "relative";
            color-modes = true;
            cursorline = true;
            scrolloff = 10;
            idle-timeout = 0;
            completion-timeout = 5;
            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
            indent-guides.render = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
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
          ];
          language-server.nixd.command = "nixd";
        };
      };
    };
}
