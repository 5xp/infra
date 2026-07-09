{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "Vague";
        font-size = 20;
        font-feature = "-calt";
      };
    };
  };
}
