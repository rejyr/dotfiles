{
  self,
  inputs,
  ...
}:
{
  flake.shellPackages =
    { pkgs, selfpkgs }:
    with pkgs;
    [
      selfpkgs.fastfetch
      selfpkgs.fish
      selfpkgs.tmux
      selfpkgs.starship
      selfpkgs.zellij

      selfpkgs.neovim

      bat
      bottom
      dust
      eza
      fd
      fzf
      gh
      git
      jq
      ripgrep
      rsync
      skim
      yazi
      zoxide
    ];

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
      otherShellPackages = with pkgs; [
        clang
        gcc
        unrar
        unzip
        zip
        wild

        imagemagick
      ];
    in
    {
      imports = [
      ];

      options.myFeatures.shell = {
        enable = lib.mkEnableOption "Shell Tools";
      };

      config = lib.mkIf cfg.enable {
        environment.sessionVariables.EDITOR = lib.mkOverride 901 "nvim";

        environment.systemPackages = self.shellPackages { inherit pkgs selfpkgs; } ++ otherShellPackages;
      };
    };
}
