{ ... }:
{
  xdg.configFile."skhd/skhdrc".source = ../../../config/darwin/skhd/skhdrc;
  xdg.configFile."skhd/appearance.sh" = {
    source = ../../../config/darwin/skhd/appearance.sh;
    executable = true;
  };
}
