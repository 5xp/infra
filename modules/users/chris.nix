{ self, ... }:
{
  flake.modules.homeManager.chris = {
    imports = with self.modules.homeManager; [
      audio
      helium
      ghostty
      helix
      git
      onepassword
      discord
      chatterino
      cli
      spotify
      mpv
      obs
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
          "wireshark"
        ];
        shell = pkgs.fish;
      };
      programs.fish.enable = true;

      home-manager.users.chris = {
        imports = [ self.modules.homeManager.chris ];
      };
    };
}
