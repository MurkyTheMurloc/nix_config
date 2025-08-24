{ pkgs, rustPlatform, ... }:

{

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        output = [
          "HDMI-A-1"
        ];
        modules-left = [
          "hyprland/workspaces"
        ];
        "modules-center" = [ "clock" ];
        modules-right = [
          "memory"
          "cpu"
          "network"
          "custom/gpu-usage"

        ];
        "hyprland/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "active" = "";
            "default" = "";
          };
        };
        "memory" = {
          "interval" = 30;
          "format" = "  {used:0.1f}G/{total:0.1f}G";
          "tooltip-format" = "Memory";
        };
        "bluetooth" = {
          "format" = "󰂲";
          "format-on" = "{icon}";
          "format-off" = "{icon}";
          "format-connected" = "{icon}";
          "format-icons" = {
            "on" = "󰂯";
            "off" = "󰂲";
            "connected" = "󰂱";
          };
          "tooltip-format-connected" = "{device_enumerate}";
        };
        "clock" = {
          "timezone" = "Europe/Berlin";
          "tooltip" = false;
          "format" = "{:%H:%M:%S  -  %A, %d}";
          "interval" = 1;
        };
        "network" = {
          "format-wifi" = "󰤢";
          "format-ethernet" = "󰈀 ";
          "format-disconnected" = "󰤠 ";
          "interval" = 5;
          "tooltip-format" = "{essid} ({signalStrength}%)";
          "on-click" = "nm-connection-editor";

        };

        "cpu" = {
          "interval" = 1;
          "format" = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
          "format-icons" = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          "on-click" = "ghostty -e htop";
        };
        "custom/gpu-usage" = {
          "format" = "{} {icon}";
          "exec" = "gpu-usage-waybar";
          "return-type" = "json";
          "format-icons" = "󰾲";
          "on-click" = "ghostty -e nvtop";
        };
      };

    };

    #background-color:rgba(30, 30, 46,0.5);
    style = # css
      ''
                                                       window#waybar {
                                                       margin: 0px;
        												 background:transparent;
                                                       font-weight: 500;
                                             			   }
                                     #clock {

                                       background-color:rgba(30, 30, 46,0.5);
                                       padding: 0.3rem 0.7rem;
                                       margin: 5px 0px;
                                       border-radius: 8px; /* This module is always rounded */
                                       min-width: 0;
                                       border: none;
                                       transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
                                     }
                              #modules-right {

                                       background-color:rgba(30, 30, 46,0.7);
                                       padding: 0.3rem 0.7rem;
                                       margin: 5px 0px;
                                       border-radius: 8px; /* This module is always rounded */
                                       min-width: 0;
                                       border: none;
                                       transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
                                     }
                       #modules-center {

                                       background-color:rgba(30, 30, 46,0.7);
                                       padding: 0.3rem 0.7rem;
                                       margin: 5px 0px;
                                       border-radius: 8px; /* This module is always rounded */
                                       min-width: 0;
                                       border: none;
                                       transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
                                     }
                #modules-left {

                                background-color:rgba(30, 30, 46,0.7);
                                padding: 0.3rem 0.7rem;
                                margin: 5px 0px;
                                border-radius: 8px; /* This module is always rounded */
                                min-width: 0;
                                border: none;
                                transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
                              }
      '';
  };
}
