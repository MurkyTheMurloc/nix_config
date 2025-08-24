{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.youtube-tui
    ];
    file = {
      ".config/youtube-tui/config.yaml" = {
        source = ./youtube_tui.yaml;
      };
    };
  };
}
