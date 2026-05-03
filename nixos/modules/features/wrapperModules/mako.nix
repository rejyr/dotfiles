{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.mako =
    {
      pkgs,
      lib,
      ...
    }:
    {
      config = {
        settings = {
          max-history = 5;
          sort = "+time";

          on-button-left = "invoke-default-action";
          on-button-middle = "dismiss-group";
          on-button-right = "dismiss";
          on-touch = "invoke-default-action";
          # on-notify = "exec mpv /usr/share/sounds/freedesktop/stereo/message.oga";

          font = "IosevkaNF 12";

          background-color = "#2d353bb0";
          text-color = "#d3c6aaff";
          border-color = "#a7c080ff";
          progress-color = "over #dbbc7fff";

          width = 400;
          height = 200;
          outer-margin = 20;
          margin = 0;
          padding = 10;
          border-size = 2;
          border-radius = 0;

          icons = 1;
          max-icon-size = "64";
          icon-location = "left";

          markup = 1;
          actions = 1;
          history = 1;

          format = "<b>%s</b>\\n%b";
          text-alignment = "center";

          default-timeout = 0;
          ignore-timeout = 0;
          max-visible = 5;

          layer = "top";
          anchor = "bottom-right";
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
      packages.mako = inputs.wrapper-modules.wrappers.mako.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.mako ];
      };
    };
}
