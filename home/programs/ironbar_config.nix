{ pkgs, inputs, ... }:

{
home.packages = [
  pkgs.ironbar
];
  programs.ironbar = {
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


}
