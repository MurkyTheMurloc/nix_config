{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.stylix.homeModules.stylix

    inputs.ironbar.homeManagerModules.default
    #    inputs.nix-index-database.homeModules.nix-index
    ./programs/ghostty.nix
    ./programs/yazi.nix
    ./programs/neovide.nix
    ./programs/zen_browser.nix
    ./programs/neovim.nix
    ./programs/nushell.nix
    ./programs/bluetui.nix
    ./programs/anyrun.nix
    ./hyprland.nix
    ./stylix.nix
    ./programs/starship.nix
    ./programs/lutrix.nix
    ./programs/spotify.nix
    #./programs/ironbar_config.nix
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
      pkgs.bat
      pkgs.yt-dlp
      pkgs.wl-clipboard
      pkgs.xwayland
      pkgs.meson
      pkgs.wayland-protocols
      pkgs.wayland-utils
      pkgs.wlroots
      pkgs.brave
      pkgs.legcord

      # Screenshot
      pkgs.slurp
      pkgs.grim
    ];
  };

  programs = {
    ironbar = {
      enable = true;
      systemd = true;
      config = {
        # An example:
        anchor_to_edges = true;
        position = "top";
        height = 12;
        start = [ { type = "workspaces"; } ];
        center = [
          {
            type = "clock";
            format = "%d.%m %H:%M";
          }
        ];
        end = [
          {
            type = "custom";
            name = "media";
            bar = [
              {
                "type" = "bluetooth";
                "icon_size" = 32;
                "format" = {
                  "not_found" = "";
                  "disabled" = " Off";
                  "enabled" = " On";
                  "connected" = " {device_alias}";
                  "connected_battery" = " {device_alias} • {device_battery_percent}%";
                };
                "popup" = {
                  "scrollable" = true;
                  "header" = " Enable Bluetooth";
                  "disabled" = "{adapter_status}";
                  "device" = {
                    "header" = "{device_alias}";
                    "header_battery" = "{device_alias}";
                    "footer" = "{device_status}";
                    "footer_battery" = "{device_status} • Battery {device_battery_percent}%";
                  };
                };
                "adapter_status" = {
                  "not_found" = "No Bluetooth adapters found";
                  "enabled" = "Bluetooth enabled";
                  "enabling" = "Enabling Bluetooth...";
                  "disabled" = "Bluetooth disabled";
                  "disabling" = "Disabling Bluetooth...";
                };
                "device_status" = {
                  "connected" = "Connected";
                  "connecting" = "Connecting...";
                  "disconnected" = "Disconnect";
                  "disconnecting" = "Disconnecting...";
                };
              }
              {
                "type" = "volume";
                "format" = "{icon} {percentage}%";
                "max_volume" = 100;
                "truncate" = "middle";
                "icons" = {
                  "volume_high" = "󰕾";
                  "volume_medium" = "󰖀";
                  "volume_low" = "󰕿";
                  "muted" = "󰝟";
                };
              }
            ];
          }
          {
            type = "sys_info";
            format = [
              "{cpu_percent@mean:2}% CPU {temp_c@k10temp:.0}°C"
              "{memory_used#Gi:1}/{memory_total#Gi:.1} GB"
              "{net_down:.1} ↓ | {net_up:.1} ↑ Mb/s"
            ];
            interval = {
              cpu = 2;
              memory = 5;
              temps = 5;
            };
          }

        ];
      };
      style = # css
        ''
                                                                                                                                 /* An example */
                                                                                                                                 * {
                                                                                                                                   font-family: Maple Mono;
                                                                                                                                   font-size: 13px;
                                                                                                                                   border: none;
                                                                                                                                   border-radius: 0px;
                                                                                                    							   background: none;
                                                                                                                                 }
                                                                                												 #start{
                                                                                                                                 background-color:rgba(30, 30, 46,0.1); 
                                                                      															 border-radius: 8px;

                                                                                          									   }
                                                                                												 #center{
                                                                                                                                 background-color:rgba(30, 30, 46,0.1); 
                                                                      															 border-radius: 8px;

                                                                                          									   }
                                                                                												 #end{
                                                                                                                                 background-color:rgba(30, 30, 46,0.1); 
                                                                      															 border-radius: 8px;

                                                                                          									   }
          																													   #media{
                               border: 0.2px solid;
                                                                                                                                                                  border-color: #89b4fa;
                                                                      															 border-radius: 8px;
                                                            																	 
                              																								   }
                                                            																	.clock{

                                                             border: 0.2px solid;
                                                                                                                                                                  border-color: #89b4fa;
                                                                      															 border-radius: 8px;
                                                            																	 }
                                                  .sysinfo .item{

                                                             border: 0.2px solid;
                                                                                                                                                                  border-color: #89b4fa;
                                                                      															 border-radius: 8px;
                                        																						  padding-left: 8px;

                                        																						  padding-right: 8px;
                                                  																			   }





        '';
      # package = inputs.ironbar;
      features = [
      ];
    };

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

  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

}
