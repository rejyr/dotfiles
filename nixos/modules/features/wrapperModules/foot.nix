{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.foot =
    {
      pkgs,
      lib,
      ...
    }:
    {
      config = {
        settings = {
          main = {
            term = "foot";
            font = "IosevkaNF:size=16, Noto Color Emoji:size=16";
            shell = "fish";
            pad = "8x8";
          };
          key-bindings = {
            scrollback-up-half-page = "Control+u";
            scrollback-down-half-page = "Control+d";
          };
          colors-dark = {
            alpha = 0.70;
            alpha-mode = "default";
            blur = "yes";
            background = "2d353b";
            foreground = "d3c6aa";
            flash = "e67e80";
            flash-alpha = 0.5;
            # Normal/regular colors (color palette 0-7)
            regular0 = "232a2e"; # black
            regular1 = "e67e80"; # red
            regular2 = "a7c080"; # green
            regular3 = "dbbc7f"; # yellow
            regular4 = "7fbbb3"; # blue
            regular5 = "d699b6"; # magenta
            regular6 = "83c092"; # cyan
            regular7 = "d3c6aa"; # white
            # Bright colors (color palette 8-15)
            bright0 = "232a2e"; # bright black
            bright1 = "e67e80"; # bright red
            bright2 = "a7c080"; # bright green
            bright3 = "dbbc7f"; # bright yellow
            bright4 = "7fbbb3"; # bright blue
            bright5 = "d699b6"; # bright magenta
            bright6 = "83c092"; # bright cyan
            bright7 = "d3c6aa"; # bright white
          };
        };
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.foot = inputs.wrapper-modules.wrappers.foot.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.foot ];
      };
    };
}
