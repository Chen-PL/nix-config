let
  mergeMod = subs: final: prev:
    builtins.foldl' (mods: sub: mods // (import sub.modifications final prev)) { } subs;
  mergeAdd = subs: final: prev:
    builtins.foldl' (adds: sub: adds // (import sub.additions final prev)) { } subs;
  subs = [ ./unix ./linux ./darwin ];
in
{
  additions = mergeAdd subs;
  modifications = mergeMod subs;
}
