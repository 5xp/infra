{ self, ... }:
{
  flake.modules.nixos.montauk =
    {
      pkgs,
      ...
    }:

    {
      imports = with self.modules.nixos; [
        home-manager
        chris
        niri
        helix
        onepassword
        steam
      ];

      environment.systemPackages = with pkgs; [
        vim
        wget
        git
        fastfetch
        easyeffects
        pavucontrol
        ddcutil
        usbutils
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
      };

      networking = {
        hostName = "montauk";
        networkmanager.enable = true;
      };

      time.timeZone = "America/Chicago";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      fileSystems."/mnt/arch" = {
        device = "/dev/disk/by-uuid/750a353a-dd88-4ae2-aec3-c179c59ab67f";
        fsType = "ext4";
        options = [
          "defaults"
          "nofail"
        ];
      };

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        # jack.enable = true;

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
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
      };

      programs.firefox.enable = true;

      nixpkgs.config.allowUnfree = true;

      # services.openssh.enable = true;

      system.stateVersion = "25.05";

      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
      };
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.i2c.enable = true;
    };
}
