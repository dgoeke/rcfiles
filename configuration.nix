{ config, pkgs, ... }:

let
  camlink = pkgs.callPackage /home/dg/.config/nixpkgs/pkgs/camlink.nix {};
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_5_11;
    #kernelPatches = [{
    #    name = "fix-audio";
    #    patch = /home/dg/fix-audio.patch;
    #  }];

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

  #specialisation.fixed-audio = {
  #  inheritParentConfig = true;
  #  configuration = {
  #    boot.loader.grub.configurationName = "fixed-audio";
  #    boot.kernelPatches = [
  #      {
  #        name = "fixed-audio";
  #        patch = /home/dg/fix-audio.patch;
  #      }
  #    ];
  #  };
  #};

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
  };

  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;

      daemon.config = {
        default-sample-format = "s24-32le";
        default-sample-rate = 48000;
      };

      configFile = pkgs.runCommand "default.pa" {} ''
        sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
          ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
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
    # rtkit.enable = true;
  };

  programs.fish.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "20.09"; # Did you read the comment?
}

