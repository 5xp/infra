{ ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user.name = "chris";
        user.email = "62446202+5xp@users.noreply.github.com";
        alias = {
          flog = "log --follow --stat --";
          flogp = "log --follow -p --";
          lg = "log --graph --pretty=format:'%C(yellow)%h%Creset -%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all --";
        };
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

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
      options = {
        line-numbers = true;
      };
    };
  };
}
