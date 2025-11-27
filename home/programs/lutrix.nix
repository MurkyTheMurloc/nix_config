{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.lutris
      pkgs.winetricks
      pkgs.wineWowPackages.waylandFull

    ];
  };
}
