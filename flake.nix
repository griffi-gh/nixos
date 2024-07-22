{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        asus-pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { 
            inherit inputs pkgs system; 
          };
          modules = [
            ./hosts/asus-pc
            ./configuration.nix
          ];
        };
      };
    };
}
