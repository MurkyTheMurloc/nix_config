{ inputs, pkgs, ... }:

{
  home.packages = [
    pkgs.bitwarden-cli
  ];
}
