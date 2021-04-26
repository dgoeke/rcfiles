{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "camlink";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "xkahn";
    repo = "camlink";
    rev = "fa9ab9356d39ae76435d1a5837e9b8f6d3720173";
    sha256 = "0mf9acqh9p3pwxk45p1il7q6q5yfjwnc62jhcr4phh5k5yvkpxjr";
  };

  configurePhase = "mkdir build";

  installPhase = ''
    mkdir -p $out/lib
    cp build/camlink.so $out/lib/
  '';
}
