{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # nixpkgs-stable = {
    #   url = "github:NixOS/nixpkgs/nixos-24.11";
    # };
    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
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

    # flake-programs-sqlite = {
    #   url = "github:wamserma/flake-programs-sqlite";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-master, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            # https://gitlab.matrix.org/matrix-org/olm/-/blob/6d4b5b07887821a95b144091c8497d09d377f985/README.md#important-libolm-is-now-deprecated
            # libolm is deprecated, used by some matrix clients
            "olm-3.2.16"
          ];
          firefox.enablePlasmaBrowserIntegration = true;
        };
        flake = {
          setNixPath = true;
          setFlakeRegistry = true;
        };
        overlays = import ./overlays;
      };
      # pkgs-stable = import nixpkgs-stable {
      #   inherit system;
      #   config.allowUnfree = true;
      # };
      pkgs-master = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
      nixosModules = with inputs; {
        home-manager    = home-manager.nixosModules.home-manager;
        # programs-sqlite = flake-programs-sqlite.nixosModules.programs-sqlite;
        # nix-index       = nix-index-database.nixosModules.nix-index;
      };
      homeModules = with inputs; {
        plasma-manager  = plasma-manager.homeManagerModules.plasma-manager;
      	vscode-server   = vscode-server.homeModules.default;
        nix-flatpak     = nix-flatpak.homeManagerModules.nix-flatpak;
        nix-index       = nix-index-database.hmModules.nix-index;
        # chaotic         = chaotic.homeManagerModules.default;
      };

      specialArgs = {
        inherit self inputs pkgs pkgs-master vscode-extensions system;
      };
    in {
      packages."${system}" = import ./pkgs { inherit pkgs; };

      nixosConfigurations = let
        buildNixosSystem = host: nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            (import ./hosts/${host}/configuration.nix)
            (import ./modules/base.nix)
            nixosModules.home-manager
            # nixosModules.programs-sqlite
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
                  homeModules.nix-index
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
