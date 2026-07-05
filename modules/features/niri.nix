{ self, inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input = {
            keyboard = {
              xkb.layout = "us";
            };
          };

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;

            "Mod+Q".close-window = null;
            "Mod+F".maximize-column = null;
            "Mod+Shift+F".fullscreen-window = null;
          };
        };
      };
    };
}
