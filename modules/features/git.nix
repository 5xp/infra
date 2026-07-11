{ ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user.name = "chris";
        user.email = "chris@cflo.dev";
      };
      ignores = [
        ".DS_Store"
        ".direnv/"
        ".devenv/"
      ];
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = "chris";
        user.email = "chris@cflo.dev";
        "--scope" = [
          {
            "--when".environments = [ "JJUI" ];
            ui.diff-formatter = "delta";
          }
        ];
      };
    };

    programs.jjui.enable = true;

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
      options = {
        syntax-theme = "base16";
        line-numbers = true;
        file-style = "bold blue";
        file-decoration-style = "blue ul";
        hunk-header-style = "file line-number";
        hunk-header-decoration-style = "omit";
      };
    };
  };
}
