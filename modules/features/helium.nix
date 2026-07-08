{ inputs, ... }:
{
  flake.modules.nixos.helium = {
    environment.etc."1password/custom_allowed_browsers" = {
      text = "helium\n";
      mode = "0755";
    };
  };

  flake.modules.homeManager.helium = {
    imports = [ inputs.helium-flake.homeModules.default ];

    programs.helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=auto"
      ];
    };
  };
}
