let
  inherit (builtins) foldl';
  merge = attr: final: prev:
    foldl' (total: sub: total // (import sub.${attr} final prev)) { };
  subs = [ ./unix ./linux ./darwin ];
in
{
  # partial application would not pass the stupid cheking
  additions = final: prev: merge "additions" subs final prev;
  modifications = final: prev: merge "modifications" subs final prev;
}
