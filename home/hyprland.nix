{
  config,
  inputs,
  pkgs,
  ...
}:
let
  focusScroll = pkgs.writeShellScriptBin "focus-scroll" ''
       DIR="$1"

    # Aktuelles Layout der aktiven Workspace abfragen
    layout=$(hyprctl activeworkspace -j | jq -r '.[0].layout // empty')

    if [ "$layout" = "scrolling" ]; then
        # Scrolling-Layout: Fokus in Spalte bewegen
        hyprctl layoutmsg focus "$DIR"
    else
        # Normales Layout: Fenster-Fokus bewegen
        hyprctl dispatch movefocus "$DIR"
    fi
  '';
in

let
  toggleApp = pkgs.writeShellScriptBin "toggle-app" ''
    appclass="$1"
    if hyprctl clients | grep -q "class:.*$appclass"; then
      hyprctl dispatch focuswindow "class:.*$appclass"
    else
      exec $appclass
    fi
  '';
in
{
  # services.hyprpaper = {
  #enable = true;
  #settings = {
  #splash = false;
  #preload = [ "${../home/programs/wallpapers/mojave_rice.jpg}" ];
  # wallpaper = [ ", ${../home/programs/wallpapers/mojave_rice.jpg}" ];
  #    };
  #};

  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      inputs.hyprWorkspaceLayouts.packages.${pkgs.system}.default
    ];

    xwayland = {
      enable = true;

    };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    settings = {
      plugin = {
        wslayout = {
          default_layout = "scrolling";

        };

        hyprscrolling = {
          enabled = true;
          speed = 1.0;
          column_width = 0.7;
        };
      };

      windowrule = [
        "workspace 2 , match:class com.mitchellh.ghostty"
        "workspace 3 , match:class brave-browser"
        "workspace 3 , match:class zen-beta"
        "workspace 4 , match:class spotify"
        "workspace 4 , match:class vesktop"
        "workspace 4 , match:class Slack"
      ];
      workspace = [
        "4,layoutopt:wslayout-layout:scrolling"
      ];
      exec = [
        "nu -c 'ironbar'"
      ];
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      #"$menu" = "anyrun";
      bind = [
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exit"
        "$mod, T, exec, $terminal"
        "$mod, P, exec, nu -c \"slurp | grim -g \\$in - | wl-copy\""
        "$mod SHIFT, P, exec, nu -c \"grim -o (hyprctl -j activeworkspace | from json | get monitor) - | wl-copy\""
        "$mod, F, fullscreen"
        "$mod, FG,exec, hyprctl dispatch fullscreenstate 2 1"
        "$mod SHIFT, F, togglefloating"
        "$mod SHIFT, F, resizeactive, exact 960 540"
        "$mod, mouse_up, resizeactive, 16 9"
        "$mod, mouse_down, resizeactive, -16 -9"

        "$mod, H, exec, ${focusScroll}/bin/focus-scroll h"
        "$mod, J, exec, ${focusScroll}/bin/focus-scroll d"
        "$mod, K, exec, ${focusScroll}/bin/focus-scroll u"
        "$mod, L, exec, ${focusScroll}/bin/focus-scroll l"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, NEXT, focusmonitor, +1"
        "$mod, PRIOR, focusmonitor, -1"
        "$mod SHIFT, NEXT, movecurrentworkspacetomonitor, +1"
        "$mod SHIFT, PRIOR, movecurrentworkspacetomonitor, -1"
        "$mod SHIFT, HOME, movecurrentworkspacetomonitor, +1"
        "$mod SHIFT, END, movecurrentworkspacetomonitor, -1"

        "$mod,SPACE, exec, rofi -show drun"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        "$mod, M, exec, spotify"
        "$mod, S, exec, slack"
        "$mod, D, exec, vesktop"
        "$mod, B, exec, ${toggleApp}/bin/toggle-app  brave-browser"
        "$mod, Z, exec, ${toggleApp}/bin/toggle-app  zen-beta"
      ];
      decoration = {
        shadow.enabled = false;
        rounding = 6;
        blur = {
          enabled = false;
          # single pass looks poop
          # total size = passes * size
          # 8 = 1 * 8 = 2 * 4
          passes = 2;
          size = 4;
        };
      };
      general = {
        border_size = 2;
        gaps_in = 8;
        gaps_out = 16;
        layout = "workspacelayout";

        allow_tearing = true;
      };
      input = {
        kb_layout = "eu";
        accel_profile = "flat";
        force_no_accel = true;
      };
      # Prevent color picker and screenshot tools to capture selection borders

      monitor = [
        ",preferred, auto, 1.667"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
      };
      debug = {
        full_cm_proto = true;
      };
    };
  };

  xresources = {
    path = "${config.home.homeDirectory}/.Xdefaults";
    properties = {
      "Xft.dpi" = 168;
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };
  };
  home.packages = [
    toggleApp
    focusScroll
  ];
}
