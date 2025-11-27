{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.stylix.homeModules.stylix
    #    inputs.nix-index-database.homeModules.nix-index
    ./programs/jay.nix
    ./programs/ghostty.nix
    ./programs/yazi.nix
    ./programs/eww.nix
    ./programs/neovide.nix
    ./programs/zen_browser.nix
    ./programs/neovim.nix
    ./programs/nushell.nix
    ./programs/bluetui.nix
    ./programs/waybar.nix
    ./programs/anyrun.nix
    ./hyprland.nix
    ./stylix.nix
    ./programs/starship.nix
    ./programs/lutrix.nix
    #    ./programs/telegram/telegram.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {

    username = "game_boy";
    homeDirectory = "/home/game_boy";
    # BUG: This does not work with nushell
    # (https://github.com/nix-community/home-manager/issues/4313)
    sessionVariables = { };
    #sessionCommands = ''	  '';
    packages = [
      pkgs.bitwarden-cli
      pkgs.bat
      pkgs.yt-dlp
      pkgs.deno
      pkgs.signal-desktop
      pkgs.wl-clipboard
      pkgs.xwayland
      pkgs.meson
      pkgs.wayland-protocols
      pkgs.wayland-utils
      pkgs.wlroots
      pkgs.brave
      pkgs.telegram-desktop
      pkgs.legcord
      # Languages & Language Servers
      pkgs.astro-language-server
      pkgs.biome
      pkgs.cargo
      pkgs.dprint
      pkgs.emmet-language-server
      pkgs.gleam
      pkgs.go
      pkgs.gopls
      pkgs.just
      pkgs.lua-language-server
      pkgs.nil
      pkgs.nixfmt-rfc-style
      pkgs.nodejs
      pkgs.openssl
      pkgs.python312
      pkgs.ruff
      pkgs.rust-analyzer
      pkgs.rustc
      pkgs.rustfmt
      pkgs.stylua
      pkgs.taplo
      pkgs.vscode-langservers-extracted
      pkgs.vtsls
      pkgs.eslint_d
      pkgs.pnpm
      pkgs.zoxide

      # Screenshot
      pkgs.slurp
      pkgs.grim
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.

    home-manager.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Paul Boese";
      userEmail = "boese-paul@web.de";
    };
  };
  xdg = {
    enable = true;
    desktopEntries = {
      # Remove NixOS manual
      nixos-manual = {
        name = "NixOS Manual";
        exec = "";
        noDisplay = true;
      };
    };
    mimeApps = {
      enable = true;
    };
  };

  services.playerctld.enable = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

}
