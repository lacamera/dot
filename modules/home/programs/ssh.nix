{ ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      amd64 = {
        hostname = "192.168.0.241";
        user = "root";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home.file.".ssh/allowed_signers".text = ''
    fm@mac namespaces="git" sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADPW0WfP1bqA2mw09yCuaFX3k6itWvQI6cymoA3lTa9
  '';
}
