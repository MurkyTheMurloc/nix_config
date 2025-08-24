{
  pkgs,
  inputs,
  ...
}:

{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      GDK_SCALE = 1.667;
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$env.HOME | path join \".steam/root/compatibilitytools.d\"";
      HYPRCURSOR_THEME = "macos";
      HYPRCURSOR_SIZE = 24;
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = 1;
    };
    configFile = {
      text = ''
                mkdir ($nu.data-dir | path join "vendor/autoload")
                starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
        		alias cd = z
                alias npm = pnpm
                zoxide init nushell | save -f ~/.zoxide.nu
                source ~/.zoxide.nu
      '';
    };
    loginFile = {
      text = ''
                if (tty) == "/dev/tty1" { exec hyprland }
        	  '';
    };
    plugins = [ ];
  };
}
