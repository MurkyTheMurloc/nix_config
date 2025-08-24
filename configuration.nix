# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    keyboard.qmk.enable = true;
    steam-hardware.enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver = {
    enable = false;
    videoDrivers = [ "amdgpu" ];
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.nushell;
  users.users.game_boy = {
    isNormalUser = true;
    description = "game_boy";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  services.dbus.enable = true;

  # Enable automatic login for the user.
  services.getty.autologinUser = "game_boy";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.fd
    pkgs.gcc
    pkgs.nushell
    pkgs.ripgrep
    pkgs.unzip
    pkgs.bazecor
    pkgs.zip
    pkgs.git
    pkgs.fzf
    pkgs.htop
    pkgs.zoxide
    pkgs.cmake
    pkgs.gnumake
    pkgs.tailscale
  ];
  #  fonts.packages = [nerdfonts];

  security.rtkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    #localNetworkGamesTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];

  };

  #value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  programs.gamemode.enable = true;

  programs.dconf.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  nix.gc.automatic = true;
  nix.gc.dates = "weekly"; # z. B. wöchentlich
  nix.gc.options = "--delete-older-than 1d"; # alles älter als 1 Tag löschen
  services.tailscale = {
    enable = true;
    # systemd.enable = true;
  };
}
