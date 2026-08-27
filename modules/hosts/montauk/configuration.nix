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
        audio
        niri
        onepassword
        steam
        helium
        mpv
        thunar
        flatpak
        tailscale
        stremio
        thunderbird
      ];

      environment.systemPackages = with pkgs; [
        vim
        wget
        git
        fastfetch
        ddcutil
        usbutils
        imhex
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems.ntfs = true;
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

      fileSystems = {
        "/mnt/arch" = {
          device = "/dev/disk/by-uuid/750a353a-dd88-4ae2-aec3-c179c59ab67f";
          fsType = "ext4";
          options = [
            "defaults"
            "nofail"
            "x-gvfs-show"
          ];
        };
        "/mnt/windows-games" = {
          device = "/dev/disk/by-uuid/E018DAD918DAADB2";
          fsType = "ntfs3";
          options = [
            "x-gvfs-show"
          ];
        };
      };

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };

      zramSwap = {
        enable = true;
        priority = 100;
      };

      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 8 * 1024;
        }
      ];

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

      programs.wireshark.enable = true;
      programs.wireshark.package = pkgs.wireshark;
    };
}
