{ self, inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      environment.systemPackages = [ pkgs.wl-clipboard ];
    };

  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    let
      myNoctaliaExe = lib.getExe self'.packages.myNoctalia;
    in
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          prefer-no-csd = true;
          clipboard.disable-primary = true; # disables middle-click paste

          spawn-at-startup = [
            myNoctaliaExe
          ];

          input = {
            keyboard = {
              xkb.layout = "us";
              repeat-delay = 400;
              repeat-rate = 40;
            };
            mouse.accel-profile = "flat";
            warp-mouse-to-focus = _: { };
            focus-follows-mouse = _: {
              props = {
                max-scroll-amount = "5%";
              };
            };
          };

          layout = {
            gaps = 6;
            border = {
              width = 2;
              active-color = "#bb9dbd";
              inactive-color = "#333738";
              urgent-color = "#d8647e";
            };
            focus-ring = {
              width = 1;
              active-color = "#bb9dbd";
              inactive-color = "#333738";
              urgent-color = "#00000000";
            };
            tab-indicator = {
              place-within-column = _: { };
            };
          };

          window-rules = [
            {
              clip-to-geometry = true;
              geometry-corner-radius = 8;
            }
          ];

          # https://docs.noctalia.dev/v4/getting-started/compositor-settings/niri/
          layer-rules = [
            {
              match = _: {
                props = {
                  namespace = "^noctalia-overview*";
                };
              };
              place-within-backdrop = true;
            }
          ];
          debug = {
            honor-xdg-activation-with-invalid-serial = _: { };
          };

          outputs = {
            "DP-3" = {
              mode = "2560x1440@240.002";
              scale = 1.25;
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
            };
            "DP-1" = {
              mode = "2560x1440@164.999";
              scale = 1.25;
              position = _: {
                props = {
                  x = 2048;
                  y = 0;
                };
              };
            };
          };

          recent-windows = {
            open-delay-ms = 100;
          };

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+E".spawn-sh = lib.getExe pkgs.kdePackages.dolphin;
            "Mod+R".spawn-sh = "${myNoctaliaExe} ipc call launcher toggle";
            "Alt+L".spawn-sh = "${myNoctaliaExe} ipc call lockScreen lock";

            "Mod+Q".close-window = _: { };
            "Mod+Tab".toggle-overview = _: { };

            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".fullscreen-window = _: { };
            "Mod+Ctrl+F".expand-column-to-available-width = _: { };

            "Mod+D".switch-preset-column-width = _: { };
            "Mod+Shift+D".switch-preset-window-height = _: { };
            "Mod+Ctrl+D".reset-window-height = _: { };

            "Mod+C".center-column = _: { };
            "Mod+Ctrl+C".center-visible-columns = _: { };

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";

            "Mod+V".toggle-window-floating = _: { };
            "Mod+Space".switch-focus-between-floating-and-tiling = _: { };

            "Mod+W".toggle-column-tabbed-display = _: { };

            "Mod+Shift+S".screenshot = _: {
              props = {
                show-pointer = false;
              };
            };
            "Print".screenshot-screen = _: {
              props = {
                show-pointer = false;
              };
            };
            "Alt+Print".screenshot-window = _: {
              props = {
                show-pointer = false;
              };
            };

            "Mod+H".focus-column-left = _: { };
            "Mod+J".focus-window-or-workspace-down = _: { };
            "Mod+K".focus-window-or-workspace-up = _: { };
            "Mod+L".focus-column-right = _: { };
            "Mod+Shift+H".move-column-left = _: { };
            "Mod+Shift+J".move-window-down-or-to-workspace-down = _: { };
            "Mod+Shift+K".move-window-up-or-to-workspace-up = _: { };
            "Mod+Shift+L".move-column-right = _: { };

            "Mod+Ctrl+H".focus-monitor-left = _: { };
            "Mod+Ctrl+J".focus-workspace-down = _: { };
            "Mod+Ctrl+K".focus-workspace-up = _: { };
            "Mod+Ctrl+L".focus-monitor-right = _: { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
            "Mod+Shift+Ctrl+J".move-column-to-workspace-down = _: { };
            "Mod+Shift+Ctrl+K".move-column-to-workspace-up = _: { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };

            "Mod+Alt+H".move-workspace-to-monitor-left = _: { };
            "Mod+Alt+J".move-workspace-up = _: { };
            "Mod+Alt+K".move-workspace-down = _: { };
            "Mod+Alt+L".move-workspace-to-monitor-right = _: { };

            "Mod+WheelScrollDown" = _: {
              props.cooldown-ms = 25;
              content.focus-workspace-down = _: { };
            };
            "Mod+WheelScrollUp" = _: {
              props.cooldown-ms = 25;
              content.focus-workspace-up = _: { };
            };
            "Mod+Ctrl+WheelScrollUp".focus-monitor-left = _: { };
            "Mod+Ctrl+WheelScrollDown".focus-monitor-right = _: { };
            "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
            "Mod+Shift+WheelScrollDown".focus-column-right = _: { };

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;

            "Mod+Shift+1".move-window-to-workspace = 1;
            "Mod+Shift+2".move-window-to-workspace = 2;
            "Mod+Shift+3".move-window-to-workspace = 3;
            "Mod+Shift+4".move-window-to-workspace = 4;
            "Mod+Shift+5".move-window-to-workspace = 5;
            "Mod+Shift+6".move-window-to-workspace = 6;
            "Mod+Shift+7".move-window-to-workspace = 7;
            "Mod+Shift+8".move-window-to-workspace = 8;
            "Mod+Shift+9".move-window-to-workspace = 9;

            "Mod+Home".focus-column-first = _: { };
            "Mod+End".focus-column-last = _: { };
            "Mod+Shift+Home".move-column-to-first = _: { };
            "Mod+Shift+End".move-column-to-last = _: { };

            "Mod+BracketLeft".consume-or-expel-window-left = _: { };
            "Mod+BracketRight".consume-or-expel-window-right = _: { };

            "Mod+Comma".consume-window-into-column = _: { };
            "Mod+Period".expel-window-from-column = _: { };

            "XF86AudioRaiseVolume" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "4%+"
              ];
            };
            "XF86AudioLowerVolume" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "4%-"
              ];
            };
            "XF86AudioMute" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SINK@"
                "toggle"
              ];
            };
            "XF86AudioMicMute" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SOURCE@"
                "toggle"
              ];
            };
            "XF86AudioPlay" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                (lib.getExe pkgs.playerctl)
                "play-pause"
              ];
            };
            "XF86AudioPause" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                (lib.getExe pkgs.playerctl)
                "play-pause"
              ];
            };
            "XF86AudioNext" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                (lib.getExe pkgs.playerctl)
                "next"
              ];
            };
            "XF86AudioPrev" = _: {
              props.allow-when-locked = true;
              content.spawn = [
                (lib.getExe pkgs.playerctl)
                "previous"
              ];
            };
          };
        };
      };
    };
}
