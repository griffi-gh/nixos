{ stdenv, fetchFromGitHub, fontconfig, lib }:
stdenv.mkDerivation {
  pname = "segoe-ui-linux";
  version = "1.0.0-unstable-2024-05-17";

  src = fetchFromGitHub {
    owner = "mrbvrz";
    repo = "segoe-ui-linux";
    rev = "a89213b7136da6dd5c3638db1f2c6e814c40fa84";
    sha256 = "sha256-0KXfNu/J1/OUnj0jeQDnYgTdeAIHcV+M+vCPie6AZcU=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/Microsoft/TrueType/SegoeUI/
    cp $src/font/*.ttf $out/share/fonts/Microsoft/TrueType/SegoeUI/
  '';

  nativeBuildInputs = [ fontconfig ];

  meta = with lib; {
    description = "Install segoe-ui font on linux";
    homepage = "https://github.com/mrbvrz/segoe-ui-linux";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
