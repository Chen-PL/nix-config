{
  additions = final: _prev: import ../../pkgs/linux { pkgs = final; };

  modifications = final: prev: {
    cgit-default-theme = prev.cgit.overrideAttrs (oldAttrs: {
      postPatch = oldAttrs.postPatch + ''
        substituteInPlace filters/syntax-highlighting.py \
          --replace 'pastie' 'default'
      '';
    });
  };
}
