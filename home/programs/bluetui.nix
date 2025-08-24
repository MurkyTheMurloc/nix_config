{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.bluetui
    ];
    file = {
      ".config/bluetui/config.toml" = {
        source = ./bluetui.toml;
      };
    };
  };
}
