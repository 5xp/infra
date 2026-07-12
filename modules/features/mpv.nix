{ self, inputs, ... }:
{
  flake.modules.nixos.mpv = {
    xdg.mime.defaultApplications = builtins.listToAttrs (
      map
        (t: {
          name = t;
          value = "mpv.desktop";
        })
        [
          "video/mp4"
          "video/x-matroska"
          "video/webm"
          "video/mpeg"
          "video/x-msvideo"
          "video/quicktime"
          "video/x-flv"
          "video/x-ms-wmv"
          "video/ogg"
          "video/3gpp"
          "video/3gpp2"
          "video/mp2t"
          "video/dv"
          "application/x-matroska"
          "application/vnd.rn-realmedia"
        ]
    );
  };

  flake.modules.homeManager.mpv = { pkgs, ... }: {
    programs.mpv = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMpv;
    };
  };

  perSystem = { pkgs, ... }: {
    packages.myMpv = inputs.wrapper-modules.wrappers.mpv.wrap {
      inherit pkgs;

      "mpv.conf" = {
        content = ''
          osc=no
          osd-bar=no
          title-bar=no
          keep-open=yes
        '';
      };

      script = {
        modernz = {
          path = pkgs.mpvScripts.modernz;
          opts = {
            layout = "compact";
            icon_theme = "material";
            window_top_bar = false;
            # vague theme
            osc_color = "#141415";
            title_color = "#cdcdcd";
            time_color = "#cdcdcd";
            chapter_title_color = "#cdcdcd";
            cache_info_color = "#cdcdcd";
            side_buttons_color = "#cdcdcd";
            middle_buttons_color = "#cdcdcd";
            playpause_color = "#cdcdcd";
            held_element_color = "#606079";
            hover_effect_color = "#7e98e8";
            seekbarfg_color = "#7e98e8";
            seekbarbg_color = "#606079";
            seekbar_cache_color = "#878787";
            seek_handle_color = "#7e98e8";
            seek_handle_border_color = "#aeaed1";
            nibble_color = "#6e94b2";
            nibble_current_color = "#cdcdcd";
            ab_loop_color = "#e0a363";
            thumbnail_box_color = "#1c1c24";
            thumbnail_box_outline = "#333738";
          };
        };
      };
    };
  };
}
