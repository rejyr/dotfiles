{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.userRejyr =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.userRejyr;
    in
    {
      options.myFeatures.userRejyr = {
        enable = lib.mkEnableOption "rejyr user";
      };

      config = lib.mkIf cfg.enable {
        users.users.rejyr = {
          isNormalUser = true;
          description = "Jerry Wang";
          extraGroups = [
            "networkmanager"
            "wheel"
            "dialout"
            "docker"
          ];
          packages = with pkgs; [ ];
        };

        hjem.users.rejyr = {
          user = "rejyr";
          directory = "/home/rejyr";
          clobberFiles = true;
          files = {
            # cargo
            ".cargo/config.toml".text = ''
              [target.x86_64-unknown-linux-gnu]
              linker = "clang"
              rustflags = ["-Clink-arg=--ld-path=wild"]
            '';

            # git
            ".config/git/config".text = ''
              [credential "https://gist.github.com"]
              	helper = "${lib.getExe pkgs.gh} auth git-credential"

              [credential "https://github.com"]
              	helper = "${lib.getExe pkgs.gh} auth git-credential"

              [user]
              	name = Jerry Wang
              	email = jerrylwang123@gmail.com
              [init]
              	defaultBranch = main
            '';

            # librewolf
            ".librewolf/librewolf.overrides.cfg".source = ../userConfigs/librewolf/librewolf.overrides.cfg;
          };
        };
      };
    };
}
