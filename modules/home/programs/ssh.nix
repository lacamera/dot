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

  home.file.".ssh/allowed_signers".source = ../../../config/home/ssh/allowed_signers;
}
