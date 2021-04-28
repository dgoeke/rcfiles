{ config, pkgs, lib, ... }:
let
  machine   = import ~/.config/nixpkgs/machine.nix;
  lights    = pkgs.callPackage ./pkgs/lights/lights.nix {};
  wantGui   = machine.operatingSystem != "Windows";
  hasGPGSig = machine.hostname == "dg-nix";
in
{
  home = {
    username = "dg";
    homeDirectory = "/home/dg";
    stateVersion = "21.03";
    sessionPath = [
      "/home/dg/.emacs.d/bin/"
    ];

    packages =
    [                            # these packages for all OS's
      lights
      pkgs.adoptopenjdk-bin
      pkgs.alot
      pkgs.awscli
      pkgs.babashka
      pkgs.bat                    # better cat
      pkgs.clojure pkgs.clj-kondo pkgs.leiningen
      pkgs.coreutils
      pkgs.curl
      pkgs.fd
      pkgs.fishPlugins.foreign-env
      pkgs.gnupg
      pkgs.go pkgs.gopls
      pkgs.google-chrome-beta
      pkgs.gparted
      pkgs.helm
      pkgs.htop
      pkgs.ispell
      pkgs.jq
      pkgs.keybase
      pkgs.kubectl
      pkgs.doctl
      pkgs.pandoc
      pkgs.pass
      pkgs.ranger
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.shellcheck
      pkgs.silver-searcher
      pkgs.terraform
      pkgs.tmux
      pkgs.tree
      pkgs.unzip
      pkgs.vim
      pkgs.wget
      pkgs.whois
    ]
    ++ lib.optionals wantGui   # these packages only if the OS wants a gui
    [
      pkgs.docker pkgs.docker-compose
      pkgs.gimp pkgs.imagemagick
      pkgs.keybase-gui
      pkgs.powerline-fonts
      pkgs.slack
      pkgs.spectacle  # screenshots
      pkgs.steam
      pkgs.vlc
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
    mbsync.enable = true;
    msmtp.enable = true;
    alot.enable = true;

    home-manager = {
      enable = true;
      path = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    };

    fish = {
      enable = true;
      shellInit = "fenv source ~/.secrets";
      interactiveShellInit = "tmux_autostart";
      shellAliases = {
        ls = "ls --color --classify";
        vim = "nvim";
      };
      shellAbbrs = {
        hm = "home-manager";
        gco = "git checkout";
        dc = "docker-compose";
        kc = "kubectl";
        tf = "terraform";
      };
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "f14a1d38a6c766184173b5f6c5b6db9750744113";
            sha256 = "1b280n8bh00n4vkm19zrn84km52296ljlm1zhz95jgaiwymf2x73";
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

      signing = if hasGPGSig then {
        signByDefault = true;
        key = "5BD5A0B2955DD7E7";
      } else null;

      ignores = [ "*~" ".DS_Store" ".envrc" ];
      includes = [
        {
          condition = "gitdir:~/repos/work/";
          contents.user.email = "david@whimsical.com";
        }];

      extraConfig = {
        core = { editor = "nvim"; };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
        pull = { rebase = true; };
        init = { defaultBranch = "main"; };
      };
    };

    alacritty = {
      enable = wantGui;
      settings = {
        font.size = 11;
        font.normal.family = "DejaVu Sans Mono for Powerline";
        font.normal.style = "Regular";
      };
    };

    firefox = {
      enable = wantGui;
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
        set modeline
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

      gpg = if hasGPGSig then {
        signByDefault = true;
        key = "5BD5A0B2955DD7E7";
      } else null;

      msmtp.enable = true;
      notmuch.enable = true;
      primary = true;
    };
  };

  services.emacs = {
    enable = wantGui;
    client.enable = true;
  };

  services.gpg-agent = {
    enable = hasGPGSig;
    defaultCacheTtl = 3600;
    enableSshSupport = true;
  };
}
