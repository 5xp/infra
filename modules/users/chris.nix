{ self, ... }:
{
  flake.modules.homeManager.chris = {
    imports = with self.modules.homeManager; [
      helium
      ghostty
      git
      onepassword
      discord
      chatterino
      cli
      spotify
      mpv
    ];

    home.username = "chris";
    home.stateVersion = "25.05";
    programs.fish.enable = true;
  };

  flake.modules.nixos.chris =
    { pkgs, ... }:
    {
      users.users.chris = {
        isNormalUser = true;
        description = "chris";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.fish;
      };
      programs.fish.enable = true;

      home-manager.users.chris = {
        imports = [ self.modules.homeManager.chris ];
      };
    };
}
