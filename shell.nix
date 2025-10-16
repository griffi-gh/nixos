{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    git-crypt
    nixd
    nil
    nixfmt-rfc-style
    nixfmt-tree
  ];
}
