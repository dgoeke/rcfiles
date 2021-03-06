{ config, pkgs, ... }:

let
  camlink = pkgs.callPackage /home/dg/.config/nixpkgs/pkgs/camlink.nix {};
in
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
      grub = {
        devices = [ "nodev" ];
        efiSupport = true;
        enable = true;
        useOSProber = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    ntfs3g bind camlink
  ];

  environment.variables = {
    LD_PRELOAD = "${camlink}/lib/camlink.so";
  };

  networking = {
    hostName = "dg-nix";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp6s0.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;

    extraHosts = ''
      192.168.86.31 light1
      192.168.86.32 light2
    '';
  };

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    openssh.enable = true;
    pcscd.enable = true;

    kbfs = {
      enable = true;
      mountPoint = "%t/kbfs";
      extraFlags = [ "-label %u" ];
    };

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.autoLogin = {
        enable = true;
        user = "dg";
      }; 
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      deviceSection = ''
        Option "TearFree" "true"
      '';
    };

    openvpn.servers = {
      whimsical = {
        config = '' config /root/nixos/openvpn/whimsical.ovpn '';
        autoStart = false;
        updateResolvConf = true;
      };
    };
  };

  systemd.user.services = {
    keybase.serviceConfig.Slice = "keybase.slice";

    kbfs = {
      environment = { KEYBASE_RUN_MODE = "prod"; };
      serviceConfig.Slice = "keybase.slice";
    };

    keybase-gui = {
      description = "Keybase GUI";
      requires = [ "keybase.service" "kbfs.service" ];
      after    = [ "keybase.service" "kbfs.service" ];
      serviceConfig = {
        ExecStart  = "${pkgs.keybase-gui}/share/keybase/Keybase";
        PrivateTmp = true;
        Slice      = "keybase.slice";
      };
    };
  };

  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;

      daemon.config = {
        default-sample-format = "s24le";
        default-sample-rate = 48000;
      };

      configFile = pkgs.runCommand "default.pa" {} ''
        sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
          ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
      '';

      extraConfig = ''
        load-module module-remap-source source_name=mono master=alsa_input.usb-Focusrite_Scarlett_2i2_USB_Y869CUE13B6B1F-00.analog-stereo master_channel_map=front-left channel_map=mono
      '';
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  users.users.dg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" "networkmanager" ];
    shell = pkgs.fish;
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    mosh.enable = true;
    fish.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "monthly";
      flags = [ "--all" "--filter" "until=720h" ];  # things created > 1month ago
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "20.09"; # Did you read the comment?
}

