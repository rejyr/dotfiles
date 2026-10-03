{
  inputs,
  ...
}:
{
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  options = {
  };

  config = {
    systems = inputs.nixpkgs.lib.platforms.all;
  };
}
