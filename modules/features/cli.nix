{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      tree
      imagemagick
      ffmpeg
      zip
      unzip
      p7zip
      ncdu
      typst
    ];

    programs.devenv.enable = true;
    programs.fastfetch.enable = true;
    programs.nh.enable = true;
    programs.htop.enable = true;
    programs.jq.enable = true;
    programs.ripgrep.enable = true;
    programs.zoxide.enable = true;
    programs.yt-dlp.enable = true;

    programs.bat = {
      enable = true;
      config.theme = "base16";
    };

    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
        ".jj/"
        ".devenv/"
        ".direnv/"
      ];
    };

    programs.fzf =
      let
        defaultCommand = "fd --type f --hidden --follow";
      in
      {
        enable = true;
        enableFishIntegration = true;
        defaultCommand = defaultCommand;
        fileWidget.fish = {
          command = defaultCommand;
          options = [ "--preview 'bat --color=always --style=numbers {}'" ];
        };
        changeDirWidget.fish = {
          command = "fd --type d --hidden --follow";
          options = [ "--preview 'tree -C {} | head -200'" ];
        };

        # vague theme
        colors = {
          fg = "#cdcdcd";
          bg = "#141415";
          hl = "#f3be7c";
          "fg+" = "#aeaed1";
          "bg+" = "#252530";
          "hl+" = "#f3be7c";
          border = "#606079";
          header = "#6e94b2";
          gutter = "#141415";
          spinner = "#7fa563";
          info = "#f3be7c";
          pointer = "#aeaed1";
          marker = "#d8647e";
          prompt = "#bb9dbd";
        };
      };
  };
}
