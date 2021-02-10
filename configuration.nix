{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1
    '';
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

  services.xserver = {
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

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  users.users.dg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" "networkmanager" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    ntfs3g bind
  ];

  services = {
    openssh.enable = true;
    pcscd.enable = true;
  };

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  system.stateVersion = "20.09"; # Did you read the comment?
}

