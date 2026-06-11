{inputs, ...}: let
  fn = name: flake: flake.outPath name;
  flakeRoots = builtins.mapAttrs fn inputs;
in {
  _module.args.flakeRoots = flakeRoots;
  inherit flakeRoots;
}
