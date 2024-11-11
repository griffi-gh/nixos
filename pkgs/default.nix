{ pkgs }:
builtins.listToAttrs (
  map (subdir: {
    name = subdir;
    value = pkgs.callPackage ./${subdir}/package.nix {};
  })
  (
    (builtins.filter (subdir: builtins.pathExists "${./.}/${subdir}/package.nix"))
    (builtins.attrNames (builtins.readDir ./.))
  )
)
