{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;

      useOSProber = true;
      extraEntries = ''
        menuentry "Windows 10" {
          insmod part_gpt
          insmod part_fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root B3E3-7424 
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      }'';
    };
  };

  # 7438E74838E707C6

  networking.hostName = "dg-nix";
  networking.networkmanager.enable = true;

  time.timeZone = "US/Pacific";

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;

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
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  hardware.opengl.driSupport32Bit = true;

  users.users.dg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" ];
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    wget vim curl git htop silver-searcher docker ranger gparted ntfs3g
    slack firefox zoom-us yubioath-desktop steam emacs alacritty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.pcscd.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09"; # Did you read the comment?
}

