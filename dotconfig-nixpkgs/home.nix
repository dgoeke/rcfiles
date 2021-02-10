{ config, pkgs, ... }:

let
  lights = pkgs.callPackage ./pkgs/lights/lights.nix {};
  unstable = import <nixpkgs-unstable> {};
in
{
  home = {
    username = "dg";
    homeDirectory = "/home/dg";
    stateVersion = "21.03";
    sessionPath = [
      "/home/dg/.emacs.d/bin/"
    ];

    packages = [
      lights
      pkgs.awscli
      pkgs.babashka
      pkgs.clojure pkgs.clj-kondo
      pkgs.coreutils
      pkgs.curl
      pkgs.docker pkgs.docker-compose
      pkgs.fd
      pkgs.gimp pkgs.imagemagick
      pkgs.go pkgs.gopls
      pkgs.gparted
      pkgs.helm
      pkgs.htop
      pkgs.ispell
      pkgs.jq
      pkgs.keybase pkgs.keybase-gui
      pkgs.kubectl pkgs.doctl
      pkgs.libreoffice
      pkgs.pandoc
      pkgs.powerline-fonts
      pkgs.ranger
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.spectacle  # screenshots
      pkgs.shellcheck
      pkgs.silver-searcher
      pkgs.slack
      pkgs.steam
      pkgs.terraform
      pkgs.tmux
      pkgs.tree
      pkgs.unzip
      pkgs.vim pkgs.neovim
      pkgs.vlc
      pkgs.wget
      pkgs.whois
      pkgs.yubioath-desktop
      pkgs.zathura  # document viewer
      pkgs.zoom-us
      pkgs.obs-studio
    ];
  };

  programs = {
    command-not-found.enable = true;
    emacs.enable = true;
    home-manager.enable = true;
    direnv.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "David Goeke";
      userEmail = "dg@github.dgoeke.io";
    };

    zsh = {
      enable = true;
      envExtra = ". ~/.secrets";
      prezto = {
        enable = true;
        editor.keymap = "vi";
        ssh.identities = [ "id_ed25519" ];
        caseSensitive = false;
        pmodules = [ "environment" "terminal" "editor" "history" "directory" "spectrum" "utility" "completion" "prompt" "autosuggestions" "git" "history-substring-search" "tmux" ];
        tmux.autoStartLocal = true;
        tmux.autoStartRemote = true;
        tmux.defaultSessionName = "default";
      }; 
      shellAliases = {
        hm = "home-manager";
        gco = "git checkout";
        dc = "docker-compose";
        ls = "ls --color --classify";
        vim = "nvim";
        kc = "kubectl";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font.size = 11;
        font.normal.family = "DejaVu Sans Mono for Powerline";
        font.normal.style = "Regular";
      };
    };

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        path = "6qh23uyo.default";
        settings = {
          "signon.rememberSignons" = false;
        };
      };
      profiles.Work = {
        id = 1;
        path = "8oenwcnh.Work";
        settings = {
          "signon.rememberSignons" = false;
        };
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    enableSshSupport = true;
  };
}
