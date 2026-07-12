{
  inputs,
  system ? "x86_64-linux",
  # pkgs,
  ...
} @ pkgsMusl:
# inputs.nixpkgs.legacyPackages.${system}.pkgsStatic
# import inputs.nixpkgs.pkgsStatic {
let
pkgs = pkgs.pkgsMusl;
in
import inputs.nixpkgs {
  inherit system;
  # overlays = [inputs.self.overlays.default];
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
