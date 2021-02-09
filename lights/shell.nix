{ pkgs ? import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {} }:

let
  leglight = pkgs.python38Packages.buildPythonPackage rec {
    pname = "leglight";
    version = "0.2.0";

    src = pkgs.python38Packages.fetchPypi {
      inherit pname version;
      sha256 = "0ji0qk8qnmimlqvbsw0w6f60faw2dwqh16pj5zhc6bifw4pldas1";
    };

    propagatedBuildInputs = with pkgs.python38Packages; [ requests zeroconf ];
    doCheck = false;
  };

  customPython = pkgs.python38.buildEnv.override {
    extraLibs = with pkgs.python38Packages; [ leglight click ];
  };
in
  pkgs.mkShell { buildInputs = [ customPython ]; }

