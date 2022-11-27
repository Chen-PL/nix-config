let
  inherit (builtins) foldl';
  merge = attr: final: prev:
    foldl' (total: sub: total // (import sub.${attr} final prev)) { };
  subs = [ ./unix ./linux ./darwin ];
in
{
  additions = merge "additions" subs;
  modifications = merge "modifications" subs;
}
