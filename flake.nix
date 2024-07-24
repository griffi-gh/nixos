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
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ 
    self,
    nixpkgs,
    flake-programs-sqlite,
    home-manager,
    plasma-manager,
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
        programs-sqlite = flake-programs-sqlite.nixosModules.programs-sqlite;
        home-manager    = home-manager.nixosModules.home-manager;
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
                users.user = import ./hosts/asus-pc/home/user.nix;
                extraSpecialArgs = specialArgs;
                sharedModules = [ 
                  plasma-manager.homeManagerModules.plasma-manager
                ];
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
