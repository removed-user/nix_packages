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
    hostSystem.libc = "musl";
    hostPlatform.libc = "musl";
    crossSystem = {config = "x86_64-unknown-linux-gnu";};
    localSystem = {
      #     system = "x86_64-linux"
      #   # isLinux = true;
      libc = "musl";
      #   # isMusl = true;
      #   # abi = "musl";
    };
    # bootStrap = {pkgs, ...}: pkgs.minimal-bootstrap;

    # stdenv = pkgs.pkgsStatic;
    ###
    system = "x86_64-linux";
    ####  STDENV_ARGS
    stdenv = stdenv.overrides {
      hostPlatform.libc = "musl";
    };
    ####  PKGS_ARGS
    pkgs = {
      localSystem,
      inputs,
      system,
      stdenv ? {inherit stdenv;},
      ...
    }: {
      inherit inputs system;
      imports = [./pkgs/main.nix];
    };
    libc = "musl";
    ####  MODULE_ARGS
    _module.args = {
      stdenv = {inherit stdenv;};
      pkgs = {inherit pkgs;};
      system = {inherit system;};
      libc = {inherit libc;};
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
      systems = [
        "x86_64-linux"
      ];
      # pkgs = {inherit pkgs;};
      imports = [
        # inputs.flake-parts.flakeModules.flakeModules
        inputs.flake-parts.flakeModules.modules
        inputs.flake-parts.flakeModules.debug
        inputs.flake-parts.flakeModules.partitions
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      disabledModules = [
        inputs.nixpkgs.nixosModules.notDetected
        inputs.flake-parts.flakeModules.nixosModules
        inputs.flake-parts.flakeModules.nixosConfigurations
        inputs.flake-parts.flakeModules.apps
        inputs.flake-parts.flakeModules.devShells
        inputs.flake-parts.flakeModules.formatter
      ];

      perSystem = {
        config,
        self',
        pkgs,
        system,
        ...
      }: {
        legacyPackages = {
          # inherit {(import ./package-defs/curl.nix);};
          # inherit bootStrap;
          # list = builtins.attrNames bootStrap;
          system = null;
          guix = pkgs.guix;
          guile = pkgs.guile;
          lixStatic = pkgs.lixStatic;
          libc = pkgs.musl;

          xz = pkgs.xz;
          gzip = pkgs.gzip;
          zlib = pkgs.zlib;
          zstd = pkgs.zstd;
          boehm-gc = pkgs.boehm-gc;
          lix = pkgs.lix;
          passt = pkgs.passt;
          bash = pkgs.bash;
          gcc = pkgs.gcc;
          curlMinimal = pkgs.curlMinimal.overrideAttrs {configureFlags = import ./package-defs/curl_flags.nix;};
          curl = pkgs.curl.override {};
        };

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages = {
          # bash = bootStrap.bash;
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
