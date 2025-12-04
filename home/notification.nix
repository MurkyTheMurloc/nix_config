{inputs,pkgs,...}:

{

home.packages = [
  inputs.moxnotify.packages.${pkgs.system}.default
];
  programs.moxnotify = {
    enable = true;

    config = {
      keymaps = [
        {
          mode = "n";
          keys = "d";
          action = "dismiss_notification";
        }
        {
          mode = "n";
          keys = "ge";
          action = "last_notification";
        }
      ];

      styles = [
        {
          selector = "*";
          style = {
            border = {
              color = {
                urgency_critical = "#f38ba8";
                urgency_low = "#a6e3a1";
                urgency_normal = "#cba6f7";
              };
            };
            font = {
              color = "#cdd6f4";
              family = "DejaVu Sans";
              size = 10;
            };
          };
        }

        {
          selector = [
            "next_counter"
            "prev_counter"
            "notification"
            "hints"
          ];
          style = {
            background = {
              urgency_critical = "#181825FF";
              urgency_low = "#1e1e2eFF";
              urgency_normal = "#181825FF";
            };
          };
        }

        {
          selector = "notification";
          state = "hover";
          style = {
            background = {
              urgency_critical = "#313244FF";
              urgency_low = "#313244FF";
              urgency_normal = "#313244FF";
            };
          };
        }

        {
          selector = "action";
          state = "hover";
          style = {
            background = {
              urgency_critical = "#f38ba8";
              urgency_low = "#f2cdcd";
              urgency_normal = "#f2cdcd";
            };
          };
        }

        {
          selector = "progress";
          style = {
            background = {
              urgency_critical = "#f38ba8";
              urgency_low = "#f2cdcd";
              urgency_normal = "#f2cdcd";
            };
          };
        }

        {
          selector = "dismiss";
