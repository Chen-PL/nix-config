{ lib, ... }:

let
  inherit (builtins) foldl';
  inherit (lib.attrsets) mapAttrs;
in

{
  simpleMerge = foldl' (x: y: x // y) { };

  nix-colors = {
    withHashtag = mapAttrs (_: color: "#${color}");
  };

  polybar = {
    withFont = id: s: "%{T${toString id}}${s}%{T-}";
    withColor = color: s: "%{F${color}}${s}%{F-}";
  };
}
