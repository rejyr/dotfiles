{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.bootloader =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.bootloader;
    in
    {
      options.myFeatures.bootloader = {
        enable = lib.mkEnableOption "Limine Bootloader";
        extraEntries = lib.mkOption {
          description = "boot.loader.limine.extraEntries";
          default = "";
          type = lib.types.lines;
          example = lib.literalExpresssion ''
            /Windows
                protocol: efi
                path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
        style.wallpapers = lib.mkOption {
          description = "boot.loader.limine.style.wallpapers";
          default = [ ];
          type = lib.types.listOf lib.types.path;
        };
      };

      config = lib.mkIf cfg.enable {
        boot.loader.limine = {
          enable = true;
          extraEntries = cfg.extraEntries;
          style = {
            wallpapers = cfg.style.wallpapers;
            wallpaperStyle = "centered";
          };
          extraConfig = ''
            backdrop: 2D353B
            term_palette: 232A2E;E67E80;A7C080;E69875;7FBBB3;D699B6;83C092;7A8478
            term_palette_bright: 233A2E;E67E80;A7C080;E69875;7FBBB3;D699B6;83C092;7A8478
            term_foreground: D3C6AA
            term_background: 402D353B
            term_foreground_bright: D3C6AA
            term_background_bright: 402D353B
            interface_branding_color: A7C080
            interface_help_color: A7C080
          '';
        };
        boot.loader.efi.canTouchEfiVariables = true;
      };
    };
}
