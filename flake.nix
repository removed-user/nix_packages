{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {
      inherit inputs;
    } {
      imports = [
        inputs.flake-parts.flakeModules.flakeModules
        inputs.flake-parts.flakeModules.modules
        inputs.flake-parts.flakeModules.debug
        inputs.flake-parts.flakeModules.partitions
      ];

      disabledModules = [
        inputs.flake-parts.flakeModules.nixosModules
        inputs.flake-parts.flakeModules.nixosConfigurations
        inputs.flake-parts.flakeModules.apps
        inputs.flake-parts.flakeModules.devShells
        inputs.flake-parts.flakeModules.formatter
      ];
      systems = ["x86_64-linux"];

      perSystem = let
        lib = nixpkgs.lib;
      in
        {
          config,
          # self',
          inputs',
          pkgs,
          ...
        }: let
          bootStrap = lib.recurseIntoAttrs inputs'.nixpkgs.legacyPackages.minimal-bootstrap;
          # inputs.nixpkgs.config.replaceStdenv = inputs'.nixpkgs.legacyPackages.minimal-bootstrap;
        in {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          legacyPackages = {
            config-store = "";
            inherit bootStrap;
            list = builtins.attrNames bootStrap;
          };

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages = {
            bash = bootStrap.bash;
            guix = pkgs.callPackageWith {} pkgs.guix;
          };
        };
      flake = {
        config.strictDepsByDefault = true;
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
