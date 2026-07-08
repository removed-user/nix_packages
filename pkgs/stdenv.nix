    stdenv = let
      libc = "musl";
    in
      {
      inputs,
      localSystem,
        pkgs,
        libc,
        ...
      }: {
        libc = "musl";
        # inherit  hostPlatform:
      };
