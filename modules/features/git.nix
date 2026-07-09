{ ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user.name = "chris";
        user.email = "62446202+5xp@users.noreply.github.com";
      };
      ignores = [
        ".DS_Store"
        ".direnv/"
      ];
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = "chris";
        user.email = "62446202+5xp@users.noreply.github.com";
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
