{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.niri =
    {
      pkgs,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      config = {
        runtimePkgs = with pkgs; [
          xdg-desktop-portal-gnome
          xwayland-satellite
        ];
        settings =
          let
            yes = _: { };
          in
          {
            screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png";
            prefer-no-csd = yes;
            gestures.hot-corners.off = yes;
            overview = {
              zoom = 0.35;
              workspace-shadow.off = yes;
            };
            # TODO: niri outputs
            outputs = { };
            spawn-at-startup = [
              "noctalia"
            ];
            spawn-sh-at-startup = [
            ];
            input = {
              warp-mouse-to-focus = yes;
              focus-follows-mouse = _: { props.max-scroll-amount = "0%"; };

              keyboard.xkb = {
                layout = "us";
                options = "compose:ralt,caps:escape";
              };

              touchpad = {
                tap = yes;
                dwt = yes;
                accel-profile = "flat";
              };

              mouse = {
                accel-profile = "flat";
              };
            };
            layer-rules = [
              {
                matches = [
                  { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; }
                ];
                background-effect = {
                  xray = false;
                };
              }
              {
                matches = [
                  { namespace = "^noctalia-backdrop"; }
                ];
                place-within-backdrop = true;
              }
            ];
            window-rules = [
              {
                matches = [
                  {
                    app-id = "librewolf$";
                    title = "^Picture-in-Picture$";
                  }
                ];
                open-floating = true;
              }
              {
                matches = [
                  {
                    app-id = "dev.noctalia.Noctalia.Settings";
                  }
                ];
                open-floating = true;
                default-column-width.fixed = 1080;
                default-window-height.fixed = 920;
              }

              {
                clip-to-geometry = true;
                background-effect = {
                  blur = true;
                  xray = false;
                };
              }
              {
                matches = [
                  { is-floating = true; }
                ];
                min-width = 100;
                min-height = 100;
              }
            ];
            animations = {
              exit-confirmation-open-close.off = yes;
              window-resize.custom-shader = builtins.readFile ./shaders/resize.shader;
            };
            layout = {
              gaps = 16;
              center-focused-column = "never";
              background-color = "transparent";

              preset-column-widths = [
                { proportion = 0.33333; }
                { proportion = 0.5; }
                { proportion = 0.66667; }
              ];
              default-column-width.proportion = 0.5;

              focus-ring = {
                width = 2;
                active-color = "#a7c080";
              };

              shadow = {
                on = yes;
                softness = 10;
                spread = 5;
                offset = _: {
                  props = {
                    x = 0;
                    y = 5;
                  };
                };
                color = "#0007";
              };

              struts = {
                left = 32;
                right = 32;
              };
            };
            hotkey-overlay.skip-at-startup = yes;
            debug.honor-xdg-activation-with-invalid-serial = yes;
            binds = {
              "Mod+Alt+A".spawn-sh = "noctalia msg panel-toggle control-center audio";
              "Mod+Alt+B".spawn-sh = "noctalia msg panel-toggle control-center bluetooth";
              "Mod+Alt+C".spawn-sh = "noctalia msg panel-toggle control-center calendar";
              "Mod+Alt+M".spawn-sh = "noctalia msg panel-toggle control-center media";
              "Mod+Alt+N".spawn-sh = "noctalia msg panel-toggle control-center network";
              "Mod+Alt+S".spawn-sh = "noctalia msg panel-toggle control-center system";
              "Mod+Alt+T".spawn-sh = "noctalia msg panel-toggle control-center notifications";
              "Mod+Alt+W".spawn-sh = "noctalia msg panel-toggle control-center weather";

              "Mod+Return".spawn = "foot";
              "Mod+Alt+Return".spawn = "librewolf";
              "Mod+D".spawn-sh = "noctalia msg panel-toggle launcher";
              "Mod+S".spawn-sh = "noctalia msg panel-toggle control-center";
              "Mod+Comma".spawn-sh = "noctalia msg settings-toggle";

              "Mod+Shift+C".spawn-sh = "noctalia msg notification-clear-active";

              "Mod+P".spawn-sh = "noctalia msg panel-toggle clipboard";
              "Mod+Alt+L".spawn-sh = "noctalia msg panel-toggle session";

              "Mod+Shift+Slash".show-hotkey-overlay = yes;

              "XF86MonBrightnessDown".spawn-sh = "noctalia msg brightness-down";
              "XF86MonBrightnessUp".spawn-sh = "noctalia msg brightness-up";
              "XF86AudioRaiseVolume".spawn-sh = "noctalia msg volume-up";
              "XF86AudioLowerVolume".spawn-sh = "noctalia msg volume-down";
              "XF86AudioMute".spawn-sh = "noctalia msg volume-mute";
              "XF86AudioMicMute".spawn-sh = "noctalia msg mic-mute";
              "XF86AudioPlay".spawn-sh = "noctalia msg media toggle";
              "XF86AudioStop".spawn-sh = "noctalia msg media stop";
              "XF86AudioNext".spawn-sh = "noctalia msg media next";
              "XF86AudioPrev".spawn-sh = "noctalia msg media previous";

              "Mod+Shift+Q".close-window = yes;

              "Mod+O".toggle-overview = yes;

              "Mod+Left".focus-column-left = yes;
              "Mod+Down".focus-window-down = yes;
              "Mod+Up".focus-window-up = yes;
              "Mod+Right".focus-column-right = yes;
              "Mod+H".focus-column-left = yes;
              "Mod+J".focus-window-down = yes;
              "Mod+K".focus-window-up = yes;
              "Mod+L".focus-column-right = yes;

              "Mod+Ctrl+Left".move-column-left = yes;
              "Mod+Ctrl+Down".move-window-down = yes;
              "Mod+Ctrl+Up".move-window-up = yes;
              "Mod+Ctrl+Right".move-column-right = yes;
              "Mod+Ctrl+H".move-column-left = yes;
              "Mod+Ctrl+J".move-window-down = yes;
              "Mod+Ctrl+K".move-window-up = yes;
              "Mod+Ctrl+L".move-column-right = yes;

              "Mod+Home".focus-column-first = yes;
              "Mod+End".focus-column-last = yes;
              "Mod+Ctrl+Home".move-column-to-first = yes;
              "Mod+Ctrl+End".move-column-to-last = yes;

              "Mod+Shift+Left".focus-monitor-left = yes;
              "Mod+Shift+Down".focus-monitor-down = yes;
              "Mod+Shift+Up".focus-monitor-up = yes;
              "Mod+Shift+Right".focus-monitor-right = yes;
              "Mod+Shift+H".focus-monitor-left = yes;
              "Mod+Shift+J".focus-monitor-down = yes;
              "Mod+Shift+K".focus-monitor-up = yes;
              "Mod+Shift+L".focus-monitor-right = yes;

              "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = yes;
              "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = yes;
              "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = yes;
              "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = yes;
              "Mod+Shift+Ctrl+H".move-column-to-monitor-left = yes;
              "Mod+Shift+Ctrl+J".move-column-to-monitor-down = yes;
              "Mod+Shift+Ctrl+K".move-column-to-monitor-up = yes;
              "Mod+Shift+Ctrl+L".move-column-to-monitor-right = yes;

              "Mod+Page_Down".focus-workspace-down = yes;
              "Mod+Page_Up".focus-workspace-up = yes;
              "Mod+U".focus-workspace-down = yes;
              "Mod+I".focus-workspace-up = yes;
              "Mod+Ctrl+Page_Down".move-column-to-workspace-down = yes;
              "Mod+Ctrl+Page_Up".move-column-to-workspace-up = yes;
              "Mod+Ctrl+U".move-column-to-workspace-down = yes;
              "Mod+Ctrl+I".move-column-to-workspace-up = yes;

              "Mod+Shift+Page_Down".move-workspace-down = yes;
              "Mod+Shift+Page_Up".move-workspace-up = yes;
              "Mod+Shift+U".move-workspace-down = yes;
              "Mod+Shift+I".move-workspace-up = yes;

              "Mod+Shift+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.focus-column-right = yes;
              };
              "Mod+Shift+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.focus-column-left = yes;
              };
              "Mod+Ctrl+Shift+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.move-column-right = yes;
              };
              "Mod+Ctrl+Shift+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.move-column-left = yes;
              };

              "Mod+WheelScrollRight".focus-column-right = yes;
              "Mod+WheelScrollLeft".focus-column-left = yes;
              "Mod+Ctrl+WheelScrollRight".move-column-right = yes;
              "Mod+Ctrl+WheelScrollLeft".move-column-left = yes;

              "Mod+1".focus-workspace = 1;
              "Mod+2".focus-workspace = 2;
              "Mod+3".focus-workspace = 3;
              "Mod+4".focus-workspace = 4;
              "Mod+5".focus-workspace = 5;
              "Mod+6".focus-workspace = 6;
              "Mod+7".focus-workspace = 7;
              "Mod+8".focus-workspace = 8;
              "Mod+9".focus-workspace = 9;
              "Mod+Ctrl+1".move-column-to-workspace = 1;
              "Mod+Ctrl+2".move-column-to-workspace = 2;
              "Mod+Ctrl+3".move-column-to-workspace = 3;
              "Mod+Ctrl+4".move-column-to-workspace = 4;
              "Mod+Ctrl+5".move-column-to-workspace = 5;
              "Mod+Ctrl+6".move-column-to-workspace = 6;
              "Mod+Ctrl+7".move-column-to-workspace = 7;
              "Mod+Ctrl+8".move-column-to-workspace = 8;
              "Mod+Ctrl+9".move-column-to-workspace = 9;

              "Mod+BracketLeft".consume-or-expel-window-left = yes;
              "Mod+BracketRight".consume-or-expel-window-right = yes;

              # "Mod+Comma".consume-window-into-column = yes;
              # "Mod+Period".expel-window-from-column = yes;

              "Mod+R".switch-preset-column-width = yes;
              "Mod+Shift+R".switch-preset-window-height = yes;
              "Mod+Ctrl+R".reset-window-height = yes;
              "Mod+F".maximize-column = yes;
              "Mod+Shift+F".fullscreen-window = yes;

              "Mod+Ctrl+F".expand-column-to-available-width = yes;

              "Mod+C".center-column = yes;

              "Mod+Minus".set-column-width = "-10%";
              "Mod+Equal".set-column-width = "+10%";

              "Mod+V".toggle-window-floating = yes;
              "Mod+Shift+V".switch-focus-between-floating-and-tiling = yes;

              "Mod+W".toggle-column-tabbed-display = yes;

              "Print".screenshot = yes;
              "Ctrl+Print".screenshot-screen = yes;
              "Alt+Print".screenshot-window = yes;

              "Mod+Shift+E".quit = yes;
            };
          };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.niri ];
      };
    };
}
