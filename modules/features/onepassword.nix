{ ... }:
{
  flake.modules.nixos.onepassword =
    { pkgs, lib, ... }:
    {
      programs._1password.enable = true;
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "chris" ];
      };

      systemd.user.services._1password = {
        description = "1Password";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${lib.getExe pkgs._1password-gui} --silent";
        };
      };
    };

  flake.modules.homeManager.onepassword =
    { pkgs, lib, ... }:
    let
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJouqUaT/FJ3j5J6V/yNNn7J77TztqjCSqNF6WG6cMs9";
    in
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
        user.signingKey = signingKey;
      };

      programs.jujutsu.settings = {
        signing = {
          behavior = "own";
          backend = "ssh";
          key = signingKey;
          backends.ssh.program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
        };
      };
    };
}
