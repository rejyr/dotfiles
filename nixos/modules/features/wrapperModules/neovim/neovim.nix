{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.neovim =
    {
      config,
      pkgs,
      lib,
      wlib,
      ...
    }:
    {
      options = {
        dynamicMode = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            If true, use impure config instead for fast edits

            Both versions of the package may be installed simultaneously
          '';
        };
        initLua = lib.mkOption {
          type = wlib.types.stringable;
          default = ./.;
        };
        dynamicInitLua = lib.mkOption {
          type = lib.types.either wlib.types.stringable lib.types.luaInline;
          default = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/dotfiles/nixos/modules/features/wrapperModules/neovim/'";
        };
      };
      config = {
        settings.config_directory = if config.dynamicMode then config.dynamicInitLua else config.initLua;

        specs.plugins = {
          before = [ "INIT_MAIN" ];
          data = with pkgs.vimPlugins; [
            blink-cmp
            conform-nvim
            everforest
            fzf-lua
            mini-nvim
            nui-nvim
            nvim-lspconfig
            nvim-navbuddy
            nvim-navic
            nvim-treesitter.withAllGrammars
            quicker-nvim
            rainbow-delimiters-nvim
            vim-fugitive
            vimtex
            yanky-nvim
          ];
        };
        extraPackages = with pkgs; [
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
          vscode-langservers-extracted

          eslint_d
          selene

          python314Packages.autopep8
          prettier
          stylua
          nixfmt
        ];
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
      packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.neovim ];
      };
    };
}
