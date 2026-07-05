{ ... }:
{
  flake.modules.nixos.onepassword = {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "chris" ];
    };
  };

  flake.modules.homeManager.onepassword =
    { pkgs, lib, ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*".identityAgent = "~/.1password/agent.sock";
      };

      programs.git.settings = {
        gpg.format = "ssh";
        "gpg \"ssh\"".program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
        commit.gpgsign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJouqUaT/FJ3j5J6V/yNNn7J77TztqjCSqNF6WG6cMs9";
      };
    };
}
