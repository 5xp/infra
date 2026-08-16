{
  flake.modules.nixos.audio = {
    programs.dconf.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber.extraConfig.disableSuspendOnIdle = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "~alsa_input.*";
              }
              {
                "node.name" = "~alsa_output.*";
              }
            ];
            actions.update-props = {
              "session.suspend-timeout-seconds" = 0;
            };
          }
        ];
      };
    };
  };

  flake.modules.homeManager.audio = { pkgs, ... }: {
    services.easyeffects.enable = true;
    home.packages = [ pkgs.pavucontrol ];
  };
}
