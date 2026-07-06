{ self, ... }:
{
  flake.modules.homeManager.chris = {
    imports = with self.modules.homeManager; [
      git
      onepassword
      discord
      chatterino
    ];

    home.username = "chris";
    home.stateVersion = "25.05";
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
