{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nix =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.nix;
    in
    {
      options.myFeatures.nix = {
        enable = lib.mkEnableOption "Nix";
      };

      config = lib.mkIf cfg.enable {
        nixpkgs.config.allowUnfree = true;

        programs.nix-ld = {
          enable = true;
          libraries = with pkgs; [
            zlib
            zstd
            stdenv.cc.cc
            curl
            openssl
            attr
            libssh
            bzip2
            libxml2
            acl
            libsodium
            util-linux
            xz
            systemd
          ];
        };

        # fix ldconfig by pointing it at nix-ld libraries
        environment.systemPackages = [
          (lib.hiPrio (
            pkgs.writeShellScriptBin "ldconfig" ''
              exec ${pkgs.glibc.bin}/bin/ldconfig -C ${
                pkgs.runCommand "nix-ld-ld.so.cache" { } ''
                  ${pkgs.glibc.bin}/bin/ldconfig -X -f /dev/null -C $out ${
                    lib.concatMapStringsSep " " (p: "${lib.getLib p}/lib") config.programs.nix-ld.libraries
                  }
                ''
              } "$@"
            ''
          ))
        ];

        nix.gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
}
