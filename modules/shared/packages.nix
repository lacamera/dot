{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bashInteractive
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
