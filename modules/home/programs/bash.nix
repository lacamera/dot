{ ... }:
{
  home.file.".bashrc".source = ../../../config/home/bash/bashrc;
  home.file.".profile".text = ''
    #!/bin/sh
    . "$HOME/.bashrc"
  '';
  home.file.".inputrc".text = ''
    set keymap vi
    set editing-mode vi
    set enable-bracketed-paste on

    $if mode=vi
      set keymap vi-insert
      Control-l: clear-screen
    $endif
  '';
}
