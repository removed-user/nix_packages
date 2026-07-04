let
  stdenv = {...}: {
    buildPlatform.libc = "musl";
  };
in
  {
    inputs,
    system ? "x86_64-linux",
    # pkgs,
    ...
  } @ pkgs:
    import inputs.nixpkgs {
      inherit system;
      # overlays = [inputs.self.overlays.default];
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      config = {
        # inherit pkgs;
        # overrideCC = inputs.nixpkgs.pkgs.musl;
        # libc = inputs.nixpkgs.pkgs.musl;
        strictDepsByDefault = true;
        warnUndeclaredOptions = true;
        # nix = nix // lix;
        structuredAttrsByDefault = true;
        checkMeta = true;
      };
    }
