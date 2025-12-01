{
  config,
  pkgs,
  ...
}:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    location = "center";
    extraConfig = {
      show-icons = true;
      display-drun = "Applications";
      display-run = "Executables";
      display-window = "Windows";
      display-ssh = "SSH";
      # Default has `<span weight='light' size='small'><i>({generic})</i></span>`
      drun-display-format = "{name}";
    };

  };
}
