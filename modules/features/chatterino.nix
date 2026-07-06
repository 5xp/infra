{
  flake.modules.homeManager.chatterino = { pkgs, ... }: {
    home.packages = [ pkgs.chatterino7 ];
  };
}
