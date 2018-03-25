# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }: let
  interface = "eth0";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/telegraf.nix
      ../../modules/config/dnsupdate.nix
      
      ../../modules
    ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  };

  systemd.network = {
    enable = true;
    networks."${interface}" = {
      name = interface;
      address = [ "192.168.1.2/24" ];
      gateway = [ "192.168.1.1" ];
      dns = [ "127.0.0.1" "::1" ];
      extraConfig = ''
        [IPv6AcceptRA]
        UseDNS=no
      '';
    };
  };
  networking.hostName = "RasPi2"; # Define your hostname.

  # Use ARM binary cache
  # Currently broken
  # nix.binaryCaches = [ "http://nixos-arm.dezgeg.me/channel" ];
  nix.binaryCachePublicKeys = [ "nixos-arm.dezgeg.me-1:xBaUKS3n17BZPKeyxL4JfbTqECsT+ysbDJz29kLFRW0=%" ];

  # List services that you want to enable:

  # Set SSH port
  services.openssh.ports = [4242];

  # Unbound DNS server
  services.unbound = {
    enable = true;
    allowedAccess = [ "192.168.1.0/24" "2601:18a:0:7829::/64" "172.17.0.0/16" ];
    interfaces = [ "0.0.0.0" "::0" ];
    forwardAddresses = [ "8.8.8.8" ];
    extraConfig = ''
      # Continue server section
        num-threads: 4
        so-reuseport: yes
        prefetch: yes

        local-zone: "raspi2.benwolsieffer.com" typetransparent
        local-data: "raspi2.benwolsieffer.com A 192.168.1.2"

        local-zone: "odroid-xu4.benwolsieffer.com" typetransparent
        local-data: "odroid-xu4.benwolsieffer.com A 192.168.1.3"

        local-zone: "dell-optiplex-780.benwolsieffer.com" typetransparent
        local-data: "dell-optiplex-780.benwolsieffer.com A 192.168.1.4"

        local-zone: "hp-z420.benwolsieffer.com" typetransparent
        local-data: "hp-z420.benwolsieffer.com A 192.168.1.5"

        local-zone: "arch.benwolsieffer.com" typetransparent
        local-data: "arch.benwolsieffer.com A 192.168.1.5"

        local-zone: "hydra.benwolsieffer.com" typetransparent
        local-data: "hydra.benwolsieffer.com A 192.168.1.5"

        local-zone: "hackerhats.benwolsieffer.com" typetransparent
        local-data: "hackerhats.benwolsieffer.com A 192.168.1.5"

        local-zone: "rock64.benwolsieffer.com" typetransparent
        local-data: "rock64.benwolsieffer.com A 192.168.1.6"

    remote-control:
      control-enable: no
    '';
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 8883 ];

  # Enable SD card TRIM
  services.fstrim.enable = true;
}
