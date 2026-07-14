{
  inputs,
  system ? "x86_64-linux",
  ...
} @ pkgs: let
  pkgs = pkgs.pkgsMusl;
in
  import inputs.nixpkgs.outPath {
    inherit system;
    config = {
      # inherit pkgs;
      # overrideCC = inputs.nixpkgs.pkgs.musl;
      # libc = inputs.nixpkgs.pkgs.musl;
      fetchedSourceNameDefault = "full";
      strictDepsByDefault = true;
      warnUndeclaredOptions = true;
      # nix = nix // lix;
      structuredAttrsByDefault = true;
      checkMeta = true;
    };
  }
#   hostSystem.libc = "musl";
#   hostPlatform.libc = "musl";
#   crossSystem = { config = "x86_64-unknown-linux-musl";};
#   hostPlatform.config = "x86_64-unknown-linux-musl";
#   localSystem = {
#     #     system = "x86_64-linux"
#     #   # isLinux = true;
#     # libc = "musl";
#     #   # isMusl = true;
#     #   # abi = "musl";
#   };
