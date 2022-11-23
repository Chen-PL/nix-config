# Chen's NixOS, Darwin & Home Manager configurations

![NixOS logo](https://git.cuichen.cc/nix-config/plain/assets/nixos.png)

## Currently avaliable hosts:

```
intel-nuc-12
macbook-air-2021
thinkpad-x1c-5th
linode
```

This configuration is flake-based, so you may check the output of this configuration by running:
```console
$ nix flake show git+https://git.cuichen.cc/nix-config
```

## Install

### Clone the Repository

```console
$ git clone https://git.cuichen.cc/nix-config
$ cd nix-config
```

### Bootstrap

If you don't have flake or home-manager enabled in your current system, you may run
```console
$ nix-shell
```
to enter the bootstrap envitonment.

### NixOS

```console
[nix-shell]$ sudo nixos-rebuild switch --flake .#hostname
```

### Home Manager

```console
[nix-shell]$ home-manager switch --flake .#chen@hostname
```

### macOS (Macbook Air 2021)

```console
[nix-shell]$ nix build .\#darwinConfigurations.macbook-air-2021.system -o /tmp/nix-result
[nix-shell]$ /tmp/nix-result/sw/bin/darwin-rebuild switch --flake .#chen@macbook-air-2021
[nix-shell]$ rm -rf /tmp/nix-result
```

The zsh alias `update-sys` may be used after my zsh module being applied.
