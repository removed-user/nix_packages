    sharedPackageList = [ "bat" ];
    interpolatePackages = pkgset: sharedPackageList: map (name: pkgset.${name}) sharedPackageList;
fromMusl = interpolatePackages pkgsMusl;
fromglibc = interpolatePackages pkgs;
