# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dg-nix"; # Define your hostname.

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget git vim emacs mercurial which aspell aspellDicts.en
    htop silver-searcher tmux docker fish ranger

    (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra ]; })
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:swapescape";

  # Enable the nvidia driver  
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.auto.enable = true;
  services.xserver.displayManager.auto.user = "dgoeke";
  services.xserver.desktopManager.kde5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.dgoeke = {
    isNormalUser = true;
    uid = 1000;
    description = "David Goeke";
    home = "/home/dgoeke";
    extraGroups = [ "wheel" "audio" ];
    shell = "/run/current-system/sw/bin/fish";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";
}
