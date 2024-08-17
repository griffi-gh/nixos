{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Home-manager stuff:
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Misc.
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          firefox.enablePlasmaBrowserIntegration = true;
        };
      };
      nixosModules = {
        programs-sqlite = inputs.flake-programs-sqlite.nixosModules.programs-sqlite;
        home-manager    = inputs.home-manager.nixosModules.home-manager;
      };
      homeModules = {
        plasma-manager  = inputs.plasma-manager.homeManagerModules.plasma-manager;
      	vscode-server   = inputs.vscode-server.homeModules.default;
      };
      specialArgs = {
        inherit inputs pkgs system;
      };
    in {
      nixosConfigurations = let
        buildNixosSystem = host: nixpkgs.lib.nixosSystem {
          inherit
            system
            specialArgs;
          modules = [
            (import ./hosts/${host}/configuration.nix)
            (import ./modules/base.nix)
            nixosModules.programs-sqlite
            nixosModules.home-manager {
              home-manager = {
                users.user = import ./modules/home.nix;
                extraSpecialArgs = specialArgs;
                sharedModules = [
                  homeModules.plasma-manager
                  homeModules.vscode-server {
                    services.vscode-server = {
                      enable = true;
                      nodejsPackage = pkgs.nodejs;
                    };
                  }
                ];
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
              };
            }
          ];
        };
      in {
        dell-pc = buildNixosSystem "dell-pc";
        asus-pc = buildNixosSystem "asus-pc";
      };
    };
}
