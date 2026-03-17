{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    neovim
    tmux
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
