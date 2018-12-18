{ config, lib, pkgs, secrets, ... }: {

  imports = [
    ../ssh.nix # Enable SSH on all systems
  ];

  # Include overlays
  nixpkgs.overlays = [
    (import ../../../pkgs)
    (import ../../../overlays/nixos-secrets)
  ];

  boot = {
    # Use the latest (cross-compiled) kernel. Some ARM systems and those with ZFS might use a
    # different kernel
    kernelPackages = pkgs.crossPackages.linuxPackages_latest;

    # Enable a shell if boot fails. This is disabled by default because it
    # gives root access, but someone with access to this shell would also have
    # physical access to the machine, so this doesn't really matter.
    kernelParams = [ "boot.shell_on_fail" ];
    cleanTmpDir = true;

    # Enable GRUB serial console
    loader.grub.extraConfig = ''
      serial --unit=0 --speed=115200
      terminal_input --append serial
      terminal_output --append serial
    '';
  };

  # All systems use USA Eastern Time
  time.timeZone = "America/New_York";

  # Standard set of packages
  environment.systemPackages = with pkgs; [
    htop iotop linuxPackages_latest.tmon git file vim screen usbutils
  ];

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  system.buildMachines = let
    machine = m: m // {
      sshUser = "build";
      sshKey = secrets.getSecret secrets.build.sshKey;
    };
  in {
    "HP-Z420" = machine {
      systems = [ "x86_64-linux" ];
      maxJobs = 8;
      speedFactor = 8;
      supportedFeatures = [ "big-parallel" "nixos-test" "kvm" ];
    };
    "ODROID-XU4" = machine {
      systems = [ "armv6l-linux" "armv7l-linux" ];
      maxJobs = 6;
      speedFactor = 4;
      supportedFeatures = [ "big-parallel" "nixos-test" ];
    };
    "Rock64" = machine {
      systems = [ "aarch64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "big-parallel" ];
    };
  };

  nix = {
    # Build packages in sandbox
    useSandbox = true;

    trustedUsers = [ "build" ];
    distributedBuilds = true;
    autoOptimiseStore = true;
    extraOptions = ''
      builders-use-substitutes = true
      tarball-ttl = 10
      netrc-file = ${secrets.getSecret secrets.hydra.netrc}
    '';

    # Use my binary cache
    binaryCaches = let
      isHydra = config.services.nginx.virtualHosts ? "hydra.benwolsieffer.com";
    in [ https://cache.nixos.org/ ] ++
      lib.optional (!isHydra) https://hydra.benwolsieffer.com /*++
      lib.optional (isHydra || pkgs.stdenv.hostPlatform.isAarch32) http://nixos-arm.dezgeg.me/channel*/; # Lots of timeouts make it almost unusable
    binaryCachePublicKeys = [ "nix-cache.benwolsieffer.com-1:fv34TjwD6LKli0BqclR4wRjj21WUry4eaXuaStzvpeI=" "nixos-arm.dezgeg.me-1:xBaUKS3n17BZPKeyxL4JfbTqECsT+ysbDJz29kLFRW0=%" ];
    
    nixPath = let 
      machineChannel = "/nix/var/nix/profiles/per-user/root/channels/machines.${config.networking.hostName}.channel";
    in [
      "nixpkgs=${machineChannel}/nixpkgs"
      "localpkgs=${machineChannel}"
      "nixos-config=${machineChannel}/machines/${config.networking.hostName}"
      "nixpkgs-overlays=${machineChannel}/overlays"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  # Public key for nix-copy-closure (might not be necessary with Nix 1.12?)
  # The private key is stored in Ansible Vault
  environment.etc."nix/signing-key.pub".text = ''
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1WFiLIaZVGL0/1Dk8ie
    dfACcBEEr94zZNrTRbGzlyyD1pGjwqzPTcEXCc97JzTucNqtQnTiW+rxD0yU/ZO7
    W3+1KBQPl93XHvezIItYVxEB4Rjf4GxHYqjZ/ahSesM3sK6jcbLuu1kAwrNiWBso
    qoBKfjHZW2TInUCGaFDX84T6KoXde/VcGqLghoT0D61Gmt0eTkIOpKK+FiJD8Ale
    6BahM0sMB2Z2z4WqkdNkL6b6IbFwuwd6y6OfWy5dQPxixoxU5CsZXH8xtFHjbvFD
    TCHMhkOb9YPuM/ltMKGU8/8lK+Bu9bdrTL2c3mf4UD2FAm01eZwFPDTjR8Rj+UAA
    ywIDAQAB
    -----END PUBLIC KEY-----
  '';

  # Global SSH configuration for distributed builds
  programs.ssh = let
    host = { name, port, hostName }: ''
      Host ${name}
          Port ${toString port}
          HostName ${hostName}
          IdentityFile ${secrets.getSecret secrets.build.sshKey}
    '';
  in {
    extraConfig = 
      (host {
        name = "HP-Z420";
        port = 4245;
        hostName = "hp-z420.benwolsieffer.com";
      }) +
      (host {
        name = "ODROID-XU4";
        port = 4243;
        hostName = "odroid-xu4.benwolsieffer.com";
      }) +
      (host {
        name = "Dell-Optiplex-780";
        port = 4244;
        hostName = "dell-optiplex-780.benwolsieffer.com";
      }) +
      (host {
        name = "RasPi2";
        port = 4242;
        hostName = "raspi2.benwolsieffer.com";
      }) +
      (host {
        name = "Rock64";
        port = 4246;
        hostName = "rock64.benwolsieffer.com";
      });

    knownHosts = [
      {
        hostNames = [ "hp-z420.benwolsieffer.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDFSy+BIOwCUMxM+ru0tjSOIovhGqMf8UVHj8UuRJ534";
      }
      {
        hostNames = [ "odroid-xu4.benwolsieffer.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmm8yfHhvqtXYWm7ivS8nfoqFPj3EKLTtD0+GAzpYYR";
      }
      {
        hostNames = [ "dell-optiplex-780.benwolsieffer.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODxgNjFuareM/XZEo7ZZrGddVj2Bx6RfaOTK1/DyNBJ";
      }
      {
        hostNames = [ "rock64.benwolsieffer.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0Z7O2FoK57gx5H/AvojXVXuO6OWJhN9HUAhKTJYMSS";
      }
    ];
  };

  networking = {
    firewall.enable = true;
    # Disable NixOS standard network configuration because I use systemd-networkd
    useDHCP = false;
    # Enable systemd predictable network names
    usePredictableInterfaceNames = true;

    # Don't use hostnames because DNSSEC fails unless the time is correct
    timeServers = [
      "129.6.15.27"
      "129.6.15.28"
      "129.6.15.29"
      "129.6.15.30"
      "2610:20:6F15:15::27"
      "132.163.97.1"
      "2610:20:6f97:97::4"
      "132.163.96.1"
      "2610:20:6f96:96::4"
    ];
  };

  # Delete old logs after 3 months
  services.journald.extraConfig = ''
    MaxRetentionSec=3month
  '';

  programs.bash.enableCompletion = true;
  # Stolen from Arch Linux
  programs.bash.promptInit = ''
    PS1='[\u@\h \W]\$ '

    case ''${TERM} in
      xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
        PROMPT_COMMAND=''${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "''${USER}" "''${HOSTNAME%%.*}" "''${PWD/#$HOME/\~}"'

        ;;
      screen*)
        PROMPT_COMMAND=''${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "''${USER}" "''${HOSTNAME%%.*}" "''${PWD/#$HOME/\~}"'
        ;;
    esac
  '';

  users = {
    # Don't allow normal user management
    mutableUsers = false;
    users = {
      ben = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        uid = 1000;
        hashedPassword = "$6$7kgb.Sjp3Z5G$dvj96191PzKF/ODL9gzKHxmcyApYBZOeABnwGNgeX0hBhCaKdPp2Js31mQ4rqk4HnXvDohBmUVqV4Hy3tjE661";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPvx2Ssc6lR5PXX7esEWehj2RDyyLdZW+LDM245cOM9u 64:9a:22:db:59:50:19:64:20:6e:bf:b0:db:ef:19:b9 Dell-Inspiron-15" ];
      };
      # User for distributed builds
      build = {
        isSystemUser = true;
        description = "";
        home = "/var/lib/build";
        shell = pkgs.bashInteractive;
        group = "build";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICAo5DSurLPw8PhMJq11qdqy312ie2oLV478grGUjR+B NixOS Build User" ];
      };
    };
    groups.build = {};
  };

  # My personal root CA
  security.pki.certificateFiles = [ ./root_ca.pem ];

  environment.secrets =
    secrets.mkSecret secrets.build.sshKey {} //
    secrets.mkSecret secrets.hydra.netrc {};

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
