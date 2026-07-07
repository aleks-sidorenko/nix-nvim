# Recursively collect all .nix files under `dir`, excluding any default.nix.
# Replacement for snowfall's get-non-default-nix-files-recursive.
lib: dir:
let
  collect =
    base:
    lib.concatLists (
      lib.mapAttrsToList (
        name: type:
        let
          path = base + "/${name}";
        in
        if type == "directory" then
          collect path
        else if lib.hasSuffix ".nix" name && name != "default.nix" then
          [ path ]
        else
          [ ]
      ) (builtins.readDir base)
    );
in
collect dir
