{ ... }:
{
  home.file.".ssh/config".source = ../../../config/home/ssh/config;
  home.file.".ssh/allowed_signers".source = ../../../config/home/ssh/allowed_signers;
}
