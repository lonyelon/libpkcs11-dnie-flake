{
  description = "Flake para libpkcs11-dnie";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.libpkcs11-dnie = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.stdenv.mkDerivation {
      pname = "libpkcs11-dnie";
      version = "1.6.8";

      src = pkgs.fetchurl {
        url = "https://www.dnielectronico.es/descargas/distribuciones_linux/libpkcs11-dnie_1.6.8_amd64.deb";
        sha256 = "sha256-hR10OLLAymAeSS5psrvSecDqKRqoiB2TK44KVvYmGwk=";
      };

      nativeBuildInputs = with pkgs; [ binutils xz ];

      unpackPhase = ''
        ar x $src
        tar -xf data.tar.xz
      '';

      installPhase = ''
        mkdir -p $out/lib $out/share/libpkcs11-dnie
        cp -a usr/lib/* $out/lib/
        cp -a usr/share/libpkcs11-dnie/* $out/share/libpkcs11-dnie/
      '';

      meta = with pkgs.lib; {
        description = "Biblioteca PKCS#11 para el DNIe";
        homepage = "https://www.sede.fnmt.gob.es";
        license = licenses.unfree;
        platforms = platforms.linux;
      };
    };
  };
}
