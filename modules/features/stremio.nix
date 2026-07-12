{
  flake.modules.nixos.stremio = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.stremio-linux-shell ];
  };
}
