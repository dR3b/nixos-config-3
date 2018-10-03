# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, secrets, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules
  ];

  boot = {
    loader = {
      grub.enable = false;
      #generic-extlinux-compatible.enable = true;
      raspberryPi = {
        enable = true;
        version = 3;
        firmwareConfig = ''
          initramfs initrd followkernel
          dtoverlay=lirc-rpi,gpio_out_pin=22
        '';
      };
    };
    kernelParams = [ "cma=32M" ];
    kernelPackages = lib.mkForce pkgs.crossPackages.linuxPackages_rpi;
  };

  hardware.enableRedistributableFirmware = true;

  networking.wireless = {
    enable = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      eth0 = {
        name = "eth0";
        DHCP = "v4";
        dhcpConfig.UseDNS = false;
        dns = ["192.168.1.2"];
      };
      wlan0 = {
        name = "wlan0";
        DHCP = "v4";
        dhcpConfig.UseDNS = false;
        dns = [ "192.168.1.2" "2601:18a:0:7829:ba27:ebff:fe5e:6b6e" ];
        extraConfig = ''
          [IPv6AcceptRA]
          UseDNS=no
        '';
      };
    };
  };
  networking.hostName = "Roomba"; # Define your hostname.

  # List services that you want to enable:

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  sound.enable = true;

  # Enable SD card TRIM
  services.fstrim.enable = true;

  # Override OpenBLAS to support aarch64
  /*nixpkgs.config.packageOverrides = pkgs: rec {
    openblas = pkgs.openblas.overrideAttrs (oldAttrs: rec {
      makeFlags =
        [
          "FC=gfortran"
          "PREFIX=\"$(out)\""
          "NUM_THREADS=64"
          "INTERFACE64=0"
          "NO_STATIC=1"
          "BINARY=64"
          "TARGET=ARMV8"
          "DYNAMIC_ARCH=0"
          "CC=gcc"
          "USE_OPENMP=1"
        ];
    });
  };*/

  networking.firewall.allowedTCPPorts = [
    8080 # Streaming
  ];

  environment.secrets = secrets.mkSecret secrets.Roomba.wpaSupplicantConf {
    target = "wpa_supplicant.conf";
  };
}