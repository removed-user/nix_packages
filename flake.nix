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
    lib = inputs.nixpkgs.lib;
    init_pkgs = inputs.nixpkgs.outPath + "/pkgs";
    flake-parts-lib = inputs.flake-parts.lib;
    # bootStrap = {pkgs, ...}: pkgs.minimal-bootstrap;
    ###
    system = "x86_64-linux";
    ####  STDENV_ARGS
    ####  PKGS_ARGS
    debug = true;
    pkgs = {
      inputs,
      system,
      stdenv,
      ...
    }: {
      inherit inputs system;
      imports = [./pkgs/main.nix];
    };
    ####  MODULE_ARGS
    _module.args = {
      # stdenv = {inherit stdenv;};
      pkgs = {inherit pkgs;};
      system = {inherit system;};
      stdenv = pkgs.pkgsMusl.stdenv;

      # libc = {inherit libc;};
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
	stdenv,
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
          lixStatic = pkgs.lixStatic;
          libc = pkgs.musl;

        # guile = pkgs.guile;
        guix = pkgs.guix;
guix-env =
pkgs.buildFHSEnv {
name = "guix-env";
targetPkgs = {
pkgs,
stdenv,
config,
...
}:

[

"guile_3_0"
"disarchive"
"guile-avahi"
"guile-gcrypt"
"guile-git"
"guile-gnutls"
"guile-json"
"guile-lib"
"guile-lzlib"
"guile-lzma"
"guile-semver"
"guile-sqlite3"
"guile-ssh"
"guile-zlib"
"guile-zstd"
"scheme-bytestructures"

];
};











	guile_3_0             = pkgs.guile_3_0;
	disarchive            = pkgs.disarchive;
	guile-avahi           = pkgs.guile-avahi;
	guile-gcrypt          = pkgs.guile-gcrypt;
	guile-git             = pkgs.guile-git;
	guile-gnutls          = pkgs.guile-gnutls;
	guile-json            = pkgs.guile-json;
	guile-lib             = pkgs.guile-lib;
	guile-lzlib           = pkgs.guile-lzlib;
	guile-lzma            = pkgs.guile-lzma;
	guile-semver          = pkgs.guile-semver;
	guile-sqlite3         = pkgs.guile-sqlite3;
	guile-ssh             = pkgs.guile-ssh;
	guile-zlib            = pkgs.guile-zlib;
	guile-zstd            = pkgs.guile-zstd;
	scheme-bytestructures = pkgs.scheme-bytestructures;

        xz = pkgs.xz;
        gzip = pkgs.gzip;
        zlib = pkgs.zlib;
        zstd = pkgs.zstd;
        boehm-gc = pkgs.boehm-gc;
        lix = pkgs.lix;
        passt = pkgs.passt;
        bash = pkgs.bash;
        gcc = pkgs.gcc;
        openssl = pkgs.openssl;
        curlMinimal = pkgs.curlMinimal.overrideAttrs {configureFlags = import ./package-defs/curl_flags.nix;};
        curl = pkgs.curl.override {};
#MUSLPKGS

guix-musl = pkgs.pkgsMusl.guix;
guile_3_0-musl = pkgs.pkgsMusl.guile_3_0;
disarchive-musl = pkgs.pkgsMusl.disarchive;
guile-avahi-musl = pkgs.pkgsMusl.guile-avahi;
guile-gcrypt-musl = pkgs.pkgsMusl.guile-gcrypt;
guile-git-musl = pkgs.pkgsMusl.guile-git;
guile-gnutls-musl = pkgs.pkgsMusl.guile-gnutls;
guile-json-musl = pkgs.pkgsMusl.guile-json;
guile-lib-musl = pkgs.pkgsMusl.guile-lib;
guile-lzlib-musl = pkgs.pkgsMusl.guile-lzlib;
guile-lzma-musl = pkgs.pkgsMusl.guile-lzma;
guile-semver-musl = pkgs.pkgsMusl.guile-semver;
guile-sqlite3-musl = pkgs.pkgsMusl.guile-sqlite3;
guile-ssh-musl = pkgs.pkgsMusl.guile-ssh;
guile-zlib-musl = pkgs.pkgsMusl.guile-zlib;
guile-zstd-musl = pkgs.pkgsMusl.guile-zstd;
scheme-bytestructures-musl = pkgs.pkgsMusl.scheme-bytestructures;
# guile-musl = pkgs.pkgsMusl.guile;

xz-musl = pkgs.pkgsMusl.xz;
gzip-musl = pkgs.pkgsMusl.gzip;
zlib-musl = pkgs.pkgsMusl.zlib;
zstd-musl = pkgs.pkgsMusl.zstd;
boehm-gc-musl = pkgs.pkgsMusl.boehm-gc;
lixStatic-musl = pkgs.pkgsMusl.lixStatic;
lix-musl = pkgs.pkgsMusl.lix;
passt-musl = pkgs.pkgsMusl.passt;
bash-musl = pkgs.pkgsMusl.bash;
gcc-musl = pkgs.pkgsMusl.gcc;
openssl-musl = pkgs.pkgsMusl.openssl;
curlMinimal-musl = pkgs.pkgsMusl.curlMinimal.overrideAttrs { configureFlags = import ./package-defs/curl_flags.nix;};
curl-musl = pkgs.pkgsMusl.curl.override {};
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
