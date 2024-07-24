{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ 
    self,
    nixpkgs,
    ... 
  }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      nixosModules = {
        programs-sqlite = inputs.flake-programs-sqlite.nixosModules.programs-sqlite;
        home-manager    = inputs.home-manager.nixosModules.home-manager;
      };
      specialArgs = { 
        inherit inputs pkgs system; 
      };
    in {
      nixosConfigurations = {
        asus-pc = nixpkgs.lib.nixosSystem {
          inherit 
            system 
            specialArgs;
          modules = [
            (import ./hosts/asus-pc/configuration.nix)
            (import ./modules/base.nix)
            nixosModules.programs-sqlite
            nixosModules.home-manager {
              home-manager = {
                users.user = {
                  imports = [
                    ./hosts/asus-pc/home/user.nix
                  ];
                };
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
              };
            }
          ];
        };
      };
    };
}
