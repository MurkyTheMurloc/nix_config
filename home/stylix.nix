{ pkgs, inputs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
in
{
  home.packages = with pkgs; [
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-serif
    commit-mono # neutral
    departure-mono # bitmap
    fragment-mono # helvetica
    geist-font
    inter
    ipaexfont
    jetbrains-mono
    lora
    apple-cursor
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Maple Mono"
        "Symbols Nerd Font"
      ];
    };

  };

  stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS"; # muss dem Ordnernamen im Theme entsprechen
      size = 24;
    };
    fonts = {

      monospace = {
        package = pkgs.maple-mono.truetype;
        name = "Maple Mono";
      };

      emoji = {
        package = inputs.apple-emoji.packages.x86_64-linux.default;
        name = "Apple Color Emoji";
      };
    };

    targets = {
    };
    base16Scheme = theme;
    image = ./programs/wallpapers/mojave_rice.jpg;
    polarity = "dark";
    icons = {
      #      enable = true;
    };
    opacity = {
      terminal = 0.7;
      popups = 0.7;
      applications = 0.7;
      desktop = 0.7;
    };
    overlays.enable = true;
  };
}
