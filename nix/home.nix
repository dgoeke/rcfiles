{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;

      useOSProber = true;
      extraEntries = ''
        menuentry "Windows 10" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 7438E74838E707C6
          chainloader /Windows/Boot/EFI/bootmgfw.efi
        }
      }'';
    };
  };

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
    displayManager.autoLogin = {
      enable = true;
      user = "dg";
    }; 
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.dg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    wget vim curl git htop silver-searcher docker ranger gparted ntfs3g
    slack firefox zoom-us yubioath-desktop
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

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09"; # Did you read the comment?
}

