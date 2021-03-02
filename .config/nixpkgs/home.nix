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
      pkgs.bat   # better cat
      pkgs.adoptopenjdk-bin
      pkgs.clojure pkgs.clj-kondo pkgs.leiningen
      pkgs.coreutils
      pkgs.curl
      pkgs.docker pkgs.docker-compose
      pkgs.fd
      pkgs.fishPlugins.foreign-env
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
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    command-not-found.enable = true;
    emacs.enable = true;
    home-manager.enable = true;
    mbsync.enable = true;
    msmtp.enable = true;
    alot.enable = true;

    fish = {
      enable = true;
      shellInit = ''
        fenv source ~/.secrets
      '';
      interactiveShellInit = ''
        tmux_autostart
      '';
      shellAliases = {
        ls = "ls --color --classify";
        vim = "nvim";
      };
      shellAbbrs = {
        hm = "home-manager";
        gco = "git checkout";
        dc = "docker-compose";
        kc = "kubectl";
      };
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "fzf";
            rev = "c3defd4a922e97120503b45e26efa775bc672b50";
            sha256 = "1zfn4ii6vq444h5rghsd7biip1x3zkh9nyvzd1l8ma8ja9y6q77x";
          };
        }
      ];
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
    };

    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
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
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    enableSshSupport = true;
  };
}
