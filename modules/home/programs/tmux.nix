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

  xdg.configFile."tmux/theme-dark.conf".text = ''
    set -g pane-border-style "fg=#3c3836"
    set -g pane-active-border-style "fg=#83a598"
    set -g display-panes-active-colour "#b8bb26"
    set -g display-panes-colour "#fabd2f"
    set -g status-style "fg=#ebdbb2,bg=#1d2021"
    set -g message-style "fg=#ebdbb2,bg=#1d2021"
    setw -g window-status-style "fg=#7c6f64,bg=default"
    setw -g window-status-current-style "fg=#fabd2f,bg=default"
    setw -g window-status-bell-style "fg=#fb4934,bg=default"
  '';

  xdg.configFile."tmux/theme-light.conf".text = ''
    set -g pane-border-style "fg=#d5c4a1"
    set -g pane-active-border-style "fg=#076678"
    set -g display-panes-active-colour "#79740e"
    set -g display-panes-colour "#b57614"
    set -g status-style "fg=#504945,bg=#f2e5bc"
    set -g message-style "fg=#504945,bg=#f2e5bc"
    setw -g window-status-style "fg=#bdae93,bg=default"
    setw -g window-status-current-style "fg=#b57614,bg=default"
    setw -g window-status-bell-style "fg=#9d0006,bg=default"
  '';
}
