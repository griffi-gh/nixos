{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.05";
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
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
          permittedInsecurePackages = [
            # https://gitlab.matrix.org/matrix-org/olm/-/blob/6d4b5b07887821a95b144091c8497d09d377f985/README.md#important-libolm-is-now-deprecated
            "olm-3.2.16"
          ];
          firefox.enablePlasmaBrowserIntegration = true;
        };
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
      nixosModules = {
        programs-sqlite = inputs.flake-programs-sqlite.nixosModules.programs-sqlite;
        home-manager    = inputs.home-manager.nixosModules.home-manager;
      };
      homeModules = {
        plasma-manager  = inputs.plasma-manager.homeManagerModules.plasma-manager;
      	vscode-server   = inputs.vscode-server.homeModules.default;
        nix-flatpak     = inputs.nix-flatpak.homeManagerModules.nix-flatpak;
      };

      specialArgs = {
        inherit inputs pkgs pkgs-stable vscode-extensions system;
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
                  homeModules.nix-flatpak
                ];
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";
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
