let
  owner = "i@cuichen.cc";
in
{
  "nix" = [
    {
      url = "nix-config";
      path = "";
      desc = "Chen's Home Manager & NixOS configurations";
      inherit owner;
    }
  ];
}
