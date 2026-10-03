{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.shell =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.shell;
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
      ];

      options.myFeatures.shell = {
        enable = lib.mkEnableOption "Shell Tools";
      };

      config = lib.mkIf cfg.enable {
        environment.sessionVariables.EDITOR = lib.mkOverride 901 "nvim";

        environment.systemPackages = with pkgs; [
          selfpkgs.atuin
          selfpkgs.fastfetch
          selfpkgs.fish
          selfpkgs.tmux
          selfpkgs.starship
          selfpkgs.zellij

          selfpkgs.neovim

          bat
          bottom
          clang
          dust
          eza
          fd
          fzf
          gcc
          gh
          git
          jq
          ripgrep
          rsync
          skim
          unrar
          unzip
          wild
          yazi
          zip
          zoxide

          imagemagick
        ];
      };
    };
}
