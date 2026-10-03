{
  self,
  ...
}:
{
  flake.wrappers = {
    atuin =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.atuin ];
        settings = {
          filter_mode_shell_up_key_binding = "session";
        };
      };

    fastfetch =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.fastfetch ];
        settings = {
          logo = {
            type = "small";
            padding = {
              top = 1;
              left = 2;
            };
          };
          display = {
            separator = " ~ ";
            color = "green";
          };
          modules = [
            "break"
            {
              type = "title";
              format = "{user-name-colored}@{host-name-colored}";
              keyColor = "blue";
            }
            {
              type = "os";
              key = "os ";
              keyColor = "cyan";
            }
            {
              type = "kernel";
              key = "ker";
              keyColor = "magenta";
            }
            {
              type = "packages";
              key = "pkg";
              keyColor = "blue";
            }
            {
              type = "wm";
              key = "wm ";
              keyColor = "yellow";
            }
            {
              type = "memory";
              key = "mem";
              keyColor = "red";
            }
            "break"
            {
              type = "colors";
              symbol = "circle";
            }
          ];
        };
      };

    tmux =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.tmux ];
      };

    fish =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.fish ];
        configFile.content = builtins.readFile ../userConfigs/fish/config.fish;
      };

    starship =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.starship ];
        settings = builtins.fromTOML (builtins.readFile ../userConfigs/starship/starship.toml);
      };

    zellij =
      { wlib, pkgs, config, ... }:
      {
        imports = [ wlib.modules.default ];
        package = pkgs.zellij;
        constructFiles.config = {
          content = builtins.readFile ../userConfigs/zellij/config.kdl;
          relPath = "config.kdl";
        };
        env.ZELLIJ_CONFIG_FILE = config.constructFiles.config.path;
      };
  };

  flake.nixosModules = builtins.mapAttrs (_: v: v.install) self.wrappers;
  flake.homeModules = self.nixosModules;

  perSystem =
    { pkgs, ... }:
    {
      wrappers.control_type = "exclude";
      wrappers.packages = { };
    };
}
