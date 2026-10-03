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
        self.nixosModules.nvim
      ];

      options.myFeatures.shell = {
        enable = lib.mkEnableOption "Shell Tools";
      };

      config = lib.mkIf cfg.enable {
        myFeatures.nvim.enable = true;

        environment.systemPackages = with pkgs; [
          selfpkgs.atuin
          selfpkgs.fastfetch
          selfpkgs.fish
          selfpkgs.tmux
          selfpkgs.starship
          selfpkgs.zellij
          zoxide

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

          imagemagick
        ];
      };
    };
}
