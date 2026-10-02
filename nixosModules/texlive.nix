{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.texlive =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.texlive;
    in
    {
      options.myFeatures.texlive = {
        enable = lib.mkEnableOption "Texlive";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages =
          with pkgs;
          let
            tex = (
              pkgs.texliveMedium.withPackages (
                ps: with ps; [
                  minted
                  minted-code
                  upquote
                ]
              )
            );
          in
          [
            tex
          ];
      };
    };
}
