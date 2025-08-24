{
  config,
  inputs,
  pkgs,
  ...
}:

{
  home = {
    packages = [
      pkgs.jay
    ];
    file = {
      ".config/jay/config.toml" = {
        source = ./jay.toml;
      };
    };
  };
}
