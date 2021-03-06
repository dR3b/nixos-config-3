{ lib, config, pkgs, secrets, ... }:

with lib;

{
  imports = [
    ../../modules
    ../../modules/local/machine/raspberry-pi.nix
  ];

  sdImage = {
    firmwarePartitionID = "0x2a7208bc";
    rootPartitionUUID = "79cd7c77-b355-4d2b-b1d5-fa9207e944f2";
  };

  boot.loader.raspberryPi = {
    enable = true;
    version = 0;
    firmwareConfig = ''
      # Use the minimum amount of GPU memory
      gpu_mem=16
    '';
    uboot.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    # Enable wifi firmware
    enableRedistributableFirmware = true;
  };

  networking.wireless = {
    enable = true;
    interfaces = [ "wlan0" ];
  };

  systemd.network = {
    enable = true;
    networks."30-wlan0" = {
      name = "wlan0";
      DHCP = "v4";
    };
    networks."50-vpn-home-tap-client".DHCP = "v4";
  };
  networking.hostName = "maine-pi";

  # Services to enable

  services.openssh = {
    ports = [ 4287 ];
    hostKeys = [
      { type = "rsa"; bits = 4096; path = secrets.getSecret secrets.maine-pi.ssh.hostRsaKey; }
      { type = "ed25519"; path = secrets.getSecret secrets.maine-pi.ssh.hostEd25519Key; }
    ];
  };

  local.networking.vpn.home.tap.client = {
    enable = true;
    certificate = ./vpn/home/client.crt;
    privateKey = secrets.getSecret secrets.maine-pi.vpn.home.privateKey;
  };

  services.dnsupdate = {
    enable = true;
    addressProvider = {
      ipv4.type = "Web";
    };

    dnsServices = singleton {
      type = "NSUpdate";
      args.hostname = "maine-pi.awsmppl.com";
      includeArgs.secret_key = secrets.getSecret secrets.maine-pi.dnsupdate.secretKey;
    };
  };

  services.watchdog = {
    enable = true;
    watchdogDevice = "/dev/watchdog0";
    watchdogTimeout = 10;
    realtime = true;
  };

  local.services.waterLevelMonitor = {
    enable = true;
    influxdb.certificateSecret = secrets.maine-pi.waterLevelMonitor.influxdbCertificate;
  };

  # Enable SD card TRIM
  services.fstrim.enable = true;

  environment.secrets = mkMerge [
    (secrets.mkSecret secrets.maine-pi.dnsupdate.secretKey { user = "dnsupdate"; })
    (secrets.mkSecret secrets.maine-pi.wpaSupplicantConf {
      target = "wpa_supplicant.conf";
    })
    (secrets.mkSecret secrets.maine-pi.vpn.home.privateKey {})
    (secrets.mkSecret secrets.maine-pi.ssh.hostRsaKey {})
    (secrets.mkSecret secrets.maine-pi.ssh.hostEd25519Key {})
  ];
}
