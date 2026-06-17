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
      options.myFeatures.shell = {
        enable = lib.mkEnableOption "Shell Tools";
      };

      config = lib.mkIf cfg.enable {
        hjem.users.rejyr.files.".config/fastfetch/config.jsonc".source = ../userConfigs/fastfetch/config.jsonc;
        hjem.users.rejyr.files.".config/fish/config.fish".source = ../userConfigs/fish/config.fish;
        hjem.users.rejyr.files.".config/starship.toml".source = ../userConfigs/starship/starship.toml;

        environment.systemPackages = with pkgs; [
          selfpkgs.neovim
          selfpkgs.zellij

          atuin
          fish
          starship
          zoxide

          bat
          bottom
          clang
          dust
          eza
          fastfetch
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
