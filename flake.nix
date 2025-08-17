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
    # nixpkgs-mesa-pinned = {
    #   url = "github:nixos/nixpkgs?rev=6a0ba68039594c1382d503f68e71a5217b3eb1b9";
    # };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox = {
    #   url = "github:nix-community/flake-firefox-nightly";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # nix-flatpak = {
    #   url = "github:gmodena/nix-flatpak/latest";
    # };
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

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    fw-fanctrl = {
      url = "github:TamtamHero/fw-fanctrl/packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-system76-scheduler-integration = {
      url = "github:maxiberta/kwin-system76-scheduler-integration";
      flake = false;
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
            "dotnet-runtime-7.0.20"
            "libxml2-2.13.8"
          ];
        };
      };
      # pkgs-stable = import nixpkgs-stable {
      #   inherit system;
      #   config.allowUnfree = true;
      # };
      pkgs-master = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
      # pkgs-mesa = import nixpkgs-mesa-pinned { inherit system; };
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
      nixosModules = with inputs; {
        chaotic         = chaotic.nixosModules.default;
        home-manager    = home-manager.nixosModules.home-manager;
        nixos-hardware  = nixos-hardware.nixosModules;
        fw-fanctrl      = fw-fanctrl.nixosModules;
        # programs-sqlite = flake-programs-sqlite.nixosModules.programs-sqlite;
        # nix-index       = nix-index-database.nixosModules.nix-index;
      };
      homeModules = with inputs; {
        plasma-manager  = plasma-manager.homeManagerModules.plasma-manager;
      	vscode-server   = vscode-server.homeModules.default;
        # nix-flatpak     = nix-flatpak.homeManagerModules.nix-flatpak;
        nix-index       = nix-index-database.homeModules.nix-index;
        # chaotic         = chaotic.homeManagerModules.default;
      };

      specialArgs = {
        inherit self inputs pkgs-master vscode-extensions system;
        root = ./.;
      };
    in {
      packages."${system}" = import ./pkgs { inherit pkgs; };

      nixosConfigurations = let
        buildNixosSystem = host: extraModules: nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            (import ./hosts/${host}/configuration.nix)
            (import ./modules/base.nix)
            nixosModules.home-manager
            nixosModules.chaotic
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
                  # homeModules.nix-flatpak
                  homeModules.nix-index
                ];
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";
              };
            }
          ] ++ extraModules;
        };
      in {
        dell-pc = buildNixosSystem "dell-pc" [];
        asus-pc = buildNixosSystem "asus-pc" [];
        fw13 = buildNixosSystem "fw13" [
          nixosModules.nixos-hardware.framework-13-7040-amd
          nixosModules.fw-fanctrl.default
        ];
      };

      templates = {
        rust.path = ./templates/rust;
      };
    };
}
