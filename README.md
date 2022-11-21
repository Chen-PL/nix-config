# Chen's NixOS & Home Manager configurations

![NixOS logo](https://git.cuichen.cc/nix-config/plain/assets/nixos.png)

## Currently avaliable hosts:

```
intel-nuc-12
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
$ cd https://git.cuichen.cc/nix-config
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
