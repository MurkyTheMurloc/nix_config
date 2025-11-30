{ pkgs, ... }:

{

  nix.settings = {
    builders-use-substitutes = true;
    extra-substituters = [
      "https://anyrun.cachix.org"
    ];

    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.3;
      };
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = false;
      showResultsImmediately = true;
      maxEntries = 5;

      plugins = [
        # "${pkgs.anyrun}/lib/libapplications.so"
        # "${pkgs.anyrun}/lib/libkidex.so"

        #        "${pkgs.anyrun}/lib/libranslate.so"
      ];
    };

    extraCss = # css

      ''
                                                                                                          window {
                                                                                                      background: none;
                                                                                                      }

                                                                                                      label {
                                                                                                      background: none;
                                                                                                      }

                                                                                                      box {
                                                                                                      background: none;

                                                                                                     }
                               																		  
                                                                                                      

                                                                                                    entry {
                                                                                              		background:rgba(30, 30, 46,0.5);
                                                                                                      border: 1.0px solid;
                                                                                                      border-color: #89b4fa;
                                                                                                      border-radius: 8px;
                                                                                                      }
                                                                                                    row:selected{

                                                                                      					background:transparent;
                                                                                                        border-radius: 8px;
                                                                                                        border: 1.0px solid;
                                                                                                        border-color: #89b4fa;
                                                                                                        padding-left: 10px;
                                                                                                        }
                                                                      						
                                                                              					
                                                                                              	  list {


                                                                                              		background:rgba(30, 30, 46,0.5);
        																								margin-top: 0px;
                                                                                                        border-radius: 8px;
                                                                                                    }
                       																		
      '';

    extraConfigFiles."some-plugin.ron".text = ''
      Config(
        // für andere Plugins
        // diese Datei wird in ~/.config/anyrun/some-plugin.ron gespeichert
        // siehe die Dokumentation von xdg.configFile für verfügbare Optionen
      )
    '';
  };
}
