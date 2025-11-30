{ pkgs, ... }:

{
  # TODO: Replace with Helium
  programs.chromium = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    commandLineArgs = [ "--ozone-platform=wayland" ];
    extensions = [
      #solidjs dev tools
      { id = "kmcfjchnmmaeeagadbhoofajiopoceel"; }
      #react dev tools
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; }
    ];
  };
}
