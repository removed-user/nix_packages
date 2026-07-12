    ####  PKGS_Musl_ARGS
    pkgsMusl = {
      localSystem,
      inputs,
      system,
      stdenv,
      ...
    }: {
      inherit inputs system;
      imports = [./pkgs/musl.nix];
    };
