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
      {
        wlib,
        pkgs,
        config,
        ...
      }:
      {
        imports = [ wlib.modules.default ];
        package = pkgs.zellij;
        constructFiles.config = {
          content = builtins.readFile ../userConfigs/zellij/config.kdl;
          relPath = "config.kdl";
        };
        env.ZELLIJ_CONFIG_FILE = config.constructFiles.config.path;
      };

    neovim =
      { wlib, pkgs, ... }:
      {
        imports = [ wlib.wrapperModules.neovim ];
        # remove unused remote plugin hosts
        hosts = {
          python3.nvim-host.enable = false;
          node.nvim-host.enable = false;
          ruby.nvim-host.enable = false;
        };
        specs.general = with pkgs.vimPlugins; [
          blink-cmp
          conform-nvim
          everforest
          fzf-lua
          mini-nvim
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          nvim-navbuddy
          nvim-navic
          nui-nvim
          quicker-nvim
          rainbow-delimiters-nvim
          rustaceanvim
          vimtex
          yanky-nvim

          neogit
          diffview-nvim
          gitsigns-nvim
        ];
        runtimePkgs = with pkgs; [
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
        settings.config_directory = ../userConfigs/nvim;
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
