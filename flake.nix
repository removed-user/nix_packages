{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {
    # flake-parts-lib,
    nixpkgs,
    self,
    ...
  }: let
    _module.args.system = "x86_64-linux";
    system = _module.args.system;
    lib = nixpkgs.lib;
    flake-parts-lib = inputs.flake-parts.lib;
    # _module.args.pkgs = pkgs;
    specialArgs = {
      system = "x86_64-linux";
    };
    ###
    pkgs = _module.args.pkgs;
    ###
    _module.args.pkgs = {
      inputs,
      system ? specialArgs.system,
      ...
    }: {
      imports = [./pkgs/main.nix];
    };

    # stdenv = _module.args.stdenv;
    # _module.args.stdenv = {
    #   inputs,
    #   system ? specialArgs.system,
    #   ...
    # }: {
    #   imports = [./pkgs/stdenv.nix];
    # };
    config.debug = true;
  in
    flake-parts-lib.mkFlake {
      inherit inputs;
    } {
      imports = [
        # inputs.flake-parts.flakeModules.flakeModules
        inputs.flake-parts.flakeModules.modules
        inputs.flake-parts.flakeModules.debug
        inputs.flake-parts.flakeModules.partitions
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      disabledModules = [
        inputs.flake-parts.flakeModules.nixosModules
        inputs.flake-parts.flakeModules.nixosConfigurations
        inputs.flake-parts.flakeModules.apps
        inputs.flake-parts.flakeModules.devShells
        inputs.flake-parts.flakeModules.formatter
      ];

      perSystem = let
        bootStrap = {pkgs, ...}: lib.recurseIntoAttrs pkgs.minimal-bootstrap;
        # inputs.nixpkgs.config.replaceStdenv = inputs'.nixpkgs.legacyPackages.minimal-bootstrap;
      in
        {
          config,
          # self',
          inputs',
          pkgs,
          system,
          ...
        }: {
          self.legacyPackages = {
            inherit bootStrap;
            list = builtins.attrNames bootStrap;
            guix = inputs'.nixpkgs.legacyPackages.guix;
          };

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages = {
            bash = bootStrap.bash;
          };
        };
      flake = {
        # config.strictDepsByDefault = true;
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
