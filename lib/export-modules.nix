dir:

let
  entries = builtins.readDir dir;

  isModule = name: type:
    (type == "regular" && builtins.match ".*\\.nix" name != null && name != "default.nix")
    || (type == "directory" && builtins.pathExists (dir + "/${name}/default.nix"));

  toModule = name: type:
    if isModule name type then {
      name = builtins.replaceStrings [ ".nix" ] [ "" ] name;
      value = dir + "/${name}";
    }
    else null;

  moduleList = builtins.filter (x: x != null)
    (builtins.attrValues (builtins.mapAttrs toModule entries));
in
builtins.listToAttrs moduleList
