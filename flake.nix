{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.05";
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

  outputs = inputs@{ nixpkgs, nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          firefox.enablePlasmaBrowserIntegration = true;
        };
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
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
        inherit inputs pkgs pkgs-stable system;
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
            nixosModules.home-manager
            {
              home-manager = {
                users = {
                  user = import ./modules/home/user.nix;
                };
                extraSpecialArgs = specialArgs;
                sharedModules = [
                  { programs.home-manager.enable = true; }
                  homeModules.plasma-manager
                  homeModules.vscode-server
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
