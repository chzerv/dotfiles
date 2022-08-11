# How to use

Create the containers:

```shell
distrobox create --image archlinux:latest -n arch
distrobox create --image fedora:rawhide -n fedora
```

Run the setup scripts:

```shell
distrobox enter arch -- bash distrobox-arch.sh
distrobox enter fedora -- bash distrobox-fedora.sh
```
