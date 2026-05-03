{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.fuzzel =
    {
      pkgs,
      lib,
      ...
    }:
    {
      config = {
        settings = {
          main = {
            dpi-aware = "no";
            font = "IosevkaNF:size=24";
            line-height = 48;
            icon-theme = "Papirus-Dark";
            fields = "name,generic,comment,categories,filename,keywords";
            terminal = "alacritty -e";
            show-actions = "yes";
            exit-on-keyboard-focus-loss = "no";
            tabs = 4;
            prompt = " run: ";
            width = 40;
            lines = 5;
          };
          colors = {
            background = "2d353bb0";
            text = "d3c6aaff";
            prompt = "d3c6aaff";
            placeholder = "d3c6aaff";
            input = "d3c6aaff";
            match = "a7c080ff";
            selection = "a7c080a0";
            selection-text = "d3c6aaff";
            selection-match = "a7c080ff";
            border = "a7c080ff";
          };
          border = {
            radius = 0;
            width = 3;
          };
          dmenu = {
            exit-immediately-if-empty = "yes";
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
      packages.fuzzel = inputs.wrapper-modules.wrappers.fuzzel.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.fuzzel ];
      };
    };
}
