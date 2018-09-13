# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image.nix>

    ../../modules
  ];

  sdImage = {
    bootPartitionID = "0xacf04aa2";
    rootPartitionUUID = "e3338fee-5e7b-4cc4-ab3a-6c8acaa4746e";

    imageBaseName = "${config.networking.hostName}-sd-image";

    populateBootCommands = let
      configTxt = pkgs.writeText "config.txt" ''
        # U-Boot used to need this to work, regardless of whether UART is actually used or not.
        # TODO: check when/if this can be removed.
        enable_uart=1

        # Prevent the firmware from smashing the framebuffer setup done by the mainline kernel
        # when attempting to show low-voltage or overtemperature warnings.
        avoid_warnings=1

        kernel=u-boot-rpi.bin
      '';

      raspberrypi-uboot-builder =
        import <nixpkgs/nixos/modules/system/boot/loader/raspberrypi/uboot-builder.nix> {
          version = 1;
          inherit pkgs configTxt;
        };
    in ''
      "${raspberrypi-uboot-builder}" -t 3 -c "${config.system.build.toplevel}" -d "$NIX_BUILD_TOP/boot/"
    '';
  };

  boot = {
    loader = {
      grub.enable = false;
      raspberryPi = {
        enable = true;
        version = 1;
        uboot.enable = true;
      };
    };
  };

  systemd.network = {
    enable = true;
    networks.eth0 = {
      name = "eth0";
      DHCP = "v4";
      #dhcpConfig.UseDNS = false;
      #dns = [ "192.168.1.2" "2601:18a:0:7829:ba27:ebff:fe5e:6b6e" ];
    };
  };
  networking.hostName = "KittyCop"; # Define your hostname.

  # List services that you want to enable:

  # Set SSH port
  services.openssh.ports = [4247];

  /*services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };*/

  modules.doorman.enable = true;

  # Enable SD card TRIM
  services.fstrim.enable = true;
}
