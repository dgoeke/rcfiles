# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = "dgoeke-linux"; 
    interfaces.enp0s25.ip4 = [ { address = "10.64.64.56"; prefixLength = 24; } ];
    defaultGateway = "10.64.64.1";
    nameservers = [ "10.17.21.20" "10.17.18.20" ];
    search = [ "sj.broadcom.com" "broadcom.com" ];
    firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # List packages installed in system profile. To search by name, run:
  environment.systemPackages = with pkgs; [
    wget vim emacs git which aspell htop
    docker
    fish ranger
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  ids.gids.users = 20;
  ids.gids.lp = 21;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.dgoeke = {
    description = "David Goeke";
    group = "users";
    isNormalUser = true;
    uid = 25312;
    home = "/home/dgoeke";
    shell = "/run/current-system/sw/bin/fish";
    extraGroups = [ "users" "wheel" "networkmanager" "evntsw" "evntswb" "CC0000203444" ];
  };

  # Create groups that match NIS
  users.extraGroups = {
    evntsw.gid = 5695;
    evntswb.gid = 5698;
    CC0000203444.gid = 51208;
  };

  fileSystems = {
    "/net/home/dgoeke" = {
      device = "fs-sj1-29:/vol/vol03003/home02/dgoeke";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.16.29" ];
    };

    "/net/projects/atlas2" = {
      device = "isi-sj1-03:/ifs/projects/ntsw_sw_atlas2";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.20.76" ];
    };

    "/net/projects/atlas3" = {
      device = "isi-sj1-05:/ifs/projects/ntsw_sw_atlas3";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.22.98" ];
    };

    "/net/projects/atlas4" = {
      device = "isi-sj1-06:/ifs/projects/ntsw_sw_atlas4";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.23.101" ];
    };

    "/net/projects/atlas5" = {
      device = "isi-sj1-05:/ifs/scratch/ntsw_sw_atlas5_scratch";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.22.63" ];
    };

    "/net/projects/atlas6" = {
      device = "isi-sj1-05:/ifs/scratch/ntsw_sw_atlas6_scratch";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.22.54" ];
    };

    "/net/projects/sw19" = {
      device = "isi-sj1-05:/ifs/projects/ntsw-sw19";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "nolock" "rw" "fg" "hard" "intr" "proto=tcp" "vers=3" "sloppy" "addr=10.66.22.63" ];
    };
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
