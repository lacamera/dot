{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Francesco La Camera";
    userEmail = "fm@lacamera.org";

    aliases = {
      find = "!git ls-files | grep";
      c = "!git commit";
      cm = "!git commit -m";
      ll = "!git log --oneline";
      s = "!git status --short";
    };

    extraConfig = {
      user.signingkey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";
      core = {
        autocrlf = "input";
        eol = "lf";
      };
      color.ui = "always";
      init.defaultBranch = "main";
    };
  };
}
