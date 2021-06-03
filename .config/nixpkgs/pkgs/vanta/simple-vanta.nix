with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "vanta-${version}";
  buildInputs = [ dpkg ];

  version = "1.8.5";
  src = fetchurl {
    url = "https://vanta-agent.s3.amazonaws.com/v${version}/vanta.deb";
    sha256 = "342956d99825beb3625807979fb815633b1d8c0e4e26b0acb43f4aa29672b1b2";
  };

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    mv $out/var/vanta $out/bin      # vanta puts its binaries in /var/vanta ??

    rm -rf $out/etc/init*           # upstart stuff in init/ and init.d/
    rm -rf $out/usr/share           # only changelog.gz
    rm -rf $out/var                 # empty since we moved binaries out

    sed -i "s@/var/vanta/@$out/bin/@g" "$out/usr/lib/systemd/system/vanta.service"
  '';
}
