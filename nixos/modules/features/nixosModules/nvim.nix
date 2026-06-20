{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nvim =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.nvim;
    in
    {
      options.myFeatures.nvim = {
        enable = lib.mkEnableOption "nvim";
      };

      config = lib.mkIf cfg.enable {
        environment.sessionVariables.EDITOR = lib.mkOverride 901 "nvim";

        # string path for symlink
        hjem.users.rejyr.files.".config/nvim".source = "/home/rejyr/dotfiles/nixos/modules/features/userConfigs/nvim";

        environment.systemPackages = with pkgs; [
          neovim

          tree-sitter

          basedpyright
          bash-language-server
          clang-tools
          emmet-language-server
          eslint
          harper
          jdt-language-server
          lua-language-server
          nil
          ruff
          rust-analyzer
          sqls
          taplo
          texlab
          typescript-language-server
          vscode-css-languageserver
          vscode-json-languageserver
          # vscode-langservers-extracted

          eslint_d
          selene

          python314Packages.autopep8
          prettier
          stylua
          nixfmt
        ];
      };
    };
}
