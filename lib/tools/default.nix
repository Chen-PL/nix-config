{ lib, ... }:

let
  inherit (lib.attrsets) mapAttrs;
in

{
  # for nix-colors
  withHashtag = mapAttrs (_: color: "#${color}");
}
