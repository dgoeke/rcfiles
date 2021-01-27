{ config, pkgs, ... }:

{
  home = {
    username = "dg";
    homeDirectory = "/home/dg";
    stateVersion = "21.03";
    sessionPath = [
      "/home/dg/.emacs.d/bin/"
    ];

    packages = [
      pkgs.awscli
      pkgs.clojure pkgs.clj-kondo
      pkgs.coreutils
      pkgs.curl
      pkgs.direnv
      pkgs.docker pkgs.docker-compose
      pkgs.fd        # find improvement
      pkgs.firefox
      pkgs.gimp pkgs.imagemagick
      pkgs.go pkgs.gopls
      pkgs.gparted
      pkgs.htop
      pkgs.ispell
      pkgs.jq
      pkgs.keybase pkgs.keybase-gui
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
    ];
  };

  programs = {
    command-not-found.enable = true;
    emacs.enable = true;
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "David Goeke";
      userEmail = "dg@github.dgoeke.io";
    };

    zsh = {
      enable = true;
      prezto = {
        enable = true;
        editor.keymap = "vi";
        ssh.identities = [ "id_ed25519" ];
        caseSensitive = false;
	pmodules = [ "environment" "terminal" "editor" "history" "directory" "spectrum" "utility" "completion" "prompt" "autosuggestions" "git" "history-substring-search" "tmux" ];
	tmux.autoStartLocal = true;
	tmux.autoStartRemote = true;
	tmux.defaultSessionName = "prezto";
      }; 
      shellAliases = {
        hm = "home-manager";
        gco = "git checkout";
        dc = "docker-compose";
        ls = "ls --color --classify";
        vim = "nvim";
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
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    enableSshSupport = true;
  };
}
