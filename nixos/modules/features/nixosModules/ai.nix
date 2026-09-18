{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.ai =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.ai;
    in
    {
      options.myFeatures.ai = {
        enable = lib.mkEnableOption "AI";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
          claude-code
          claude-desktop
          claude-plugins
          # clauth
          ccusage
          claudebox
          sandbox-runtime
          skills
        ];
      };
    };
}
