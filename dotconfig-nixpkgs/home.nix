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
      pkgs.alot
      pkgs.awscli
      pkgs.babashka
      pkgs.adoptopenjdk-bin
      pkgs.clojure pkgs.clj-kondo pkgs.leiningen
      pkgs.coreutils
      pkgs.curl
      pkgs.docker pkgs.docker-compose
      pkgs.fd
      pkgs.gimp pkgs.imagemagick
      pkgs.go pkgs.gopls
      pkgs.gnupg
      pkgs.gparted
      pkgs.helm
      pkgs.htop
      pkgs.ispell
      pkgs.jq
      pkgs.keybase pkgs.keybase-gui
      pkgs.kubectl pkgs.doctl
      pkgs.libreoffice
      pkgs.pass
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
      pkgs.vim
      pkgs.vlc
      pkgs.wget
      pkgs.whois
      pkgs.yubioath-desktop
      pkgs.zathura  # document viewer
      pkgs.zoom-us
      pkgs.obs-studio
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    command-not-found.enable = true;
    emacs.enable = true;
    home-manager.enable = true;
    direnv.enable = true;
    mbsync.enable = true;
    msmtp.enable = true;
    alot.enable = true;

    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "David Goeke";
      userEmail = "dg@github.dgoeke.io";
      signing = {
        signByDefault = true;
        key = "5BD5A0B2955DD7E7";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    zsh = {
      enable = true;
      prezto = {
        extraConfig = ". ~/.secrets";
        enable = true;
        editor.keymap = "vi";
        ssh.identities = [ "id_ed25519" ];
        caseSensitive = false;
        pmodules = [ "environment" "terminal" "editor" "history" "directory"
                     "spectrum" "utility" "completion" "prompt" "autosuggestions"
                     "git" "history-substring-search" "tmux" ];
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

    neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.vim-airline
        pkgs.vimPlugins.vim-nix
      ];

      extraConfig = ''
        set mouse=a
        set ignorecase
        set pastetoggle=<F2>
        set clipboard+=unnamedplus
      '';
    };
  };

  accounts.email = {
    accounts.dgoeke-io = {
      realName = "David Goeke";
      address = "dg@dgoeke.io";
      imap.host = "imap.fastmail.com";
      smtp.host = "smtp.fastmail.com";
      userName = "dg@dgoeke.io";
      passwordCommand = "${pkgs.pass}/bin/pass fastmail";

      mbsync = {
        enable = true;
        create = "maildir";
      };

      gpg = {
        signByDefault = true;
        key = "5BD5A0B2955DD7E7";
      };

      msmtp.enable = true;
      notmuch.enable = true;
      primary = true;
    };

    accounts.gmail = {
      realName = "David Goeke";
      address = "dgoeke@gmail.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      userName = "dgoeke@gmail.com";
      passwordCommand = "${pkgs.pass}/bin/pass gmail";

      mbsync = {
        enable = true;
        create = "maildir";
      };

      gpg = {
        signByDefault = true;
        key = "5BD5A0B2955DD7E7";
      };

      msmtp.enable = true;
      notmuch.enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    enableSshSupport = true;
  };
}
