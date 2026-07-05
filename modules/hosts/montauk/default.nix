{ self, inputs, ... }:

{
  flake.nixosConfigurations.montauk = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.montauk
    ];
  };
}
