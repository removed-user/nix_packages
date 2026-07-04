{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    # flake-parts-lib,
    nixpkgs,
    self,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    flake-parts-lib = inputs.flake-parts.lib;
    bootStrap = {pkgs, ...}: lib.recurseIntoAttrs pkgs.minimal-bootstrap;
    ###
    system = "x86_64-linux";

    pkgs = {
      inputs,
      system,
      ...
    }: {
      inherit inputs system;
      imports = [./pkgs/main.nix];
    };
    _module.args = {
      pkgs = {inherit pkgs;};
      system = {inherit system;};
    };
    # stdenv = _module.args.stdenv;
    # _module.args.stdenv = {
    #   inputs,
    #   system ? specialArgs.system,
    #   ...
    # }: {
    #   imports = [./pkgs/stdenv.nix];
    # };
  in
    flake-parts-lib.mkFlake {
      inherit inputs;
    }
    {
      systems = ["x86_64-linux"];
      # pkgs = {inherit pkgs;};
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

      # let
      # inputs.nixpkgs.config.replaceStdenv = inputs'.nixpkgs.legacyPackages.minimal-bootstrap;
      # in
      perSystem = {
        config,
        self',
        pkgs,
        system,
        ...
      }: {
        legacyPackages = {
          inherit bootStrap;
          # list = builtins.attrNames bootStrap;
          guix = pkgs.guix;
        };

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages = {
          inherit system;
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
