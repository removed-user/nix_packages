{lib}: let
  flattenAttrs = prefix: attrs:
    lib.concatMapAttrs (
      name: value: let
        currentKey =
          if prefix == ""
          then name
          else "${prefix}/${name}";
      in
        if lib.isDerivation value
        then {"${currentKey}" = value;}
        else if builtins.isAttrs value
        then flattenAttrs currentKey value
        else {}
    )
    attrs;
in
  flattenAttrs ""
