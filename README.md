# Chen's Home Manager & NixOS configurations

For personal use only.

## Rebuild

### NixOS

```sh
sudo nixos-rebuild switch --flake .#hostname
```

### Home Manager

```
home-manager switch --flake .#chen@hostname
```
