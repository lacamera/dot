{ lib, pkgs, user, ... }:
{
  imports = [
    ../../modules/home
    ../../modules/shared/packages.nix
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    ../../modules/home/darwin/aerospace.nix
    ../../modules/home/darwin/skhd.nix
    ../../modules/home/darwin/mpv.nix
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
