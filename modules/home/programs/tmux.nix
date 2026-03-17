{ ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      set -g allow-passthrough on
      set -s escape-time 0
      set -g set-titles on
      set -g set-titles-string "#T"
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none
      set -g status-position top
      set -g status-justify left
      set -g allow-rename off
      set -g history-limit 128

      unbind -n MouseDown3Pane
      unbind %
      unbind '"'

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"

      set -g status-right ""
      setw -g mode-style ""
      setw -g window-status-format " #I:#W "
      setw -g window-status-current-format " #I:#W "

      if-shell '[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]' 'source-file $HOME/.config/tmux/theme-dark.conf' 'source-file $HOME/.config/tmux/theme-light.conf'
      set-hook -g client-attached 'if-shell "[ \"$(defaults read -g AppleInterfaceStyle 2>/dev/null)\" = \"Dark\" ]" "source-file $HOME/.config/tmux/theme-dark.conf" "source-file $HOME/.config/tmux/theme-light.conf"'
    '';
  };

  xdg.configFile."tmux/theme-dark.conf".source = ../../../config/home/tmux/theme-dark.conf;
  xdg.configFile."tmux/theme-light.conf".source = ../../../config/home/tmux/theme-light.conf;
}
