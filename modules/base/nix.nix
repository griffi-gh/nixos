{ pkgs, ... }: let
  buildTmpDir = "/nix/tmp";
  useLix = true;
in {
  nix = rec {
    package = if useLix then
      pkgs.lixVersions.latest
    else
      pkgs.nixVersions.git;
    settings = {
      # See https://nixos.org/manual/nix/stable/command-ref/conf-file.html
      # for a complete list of Nix configuration options.
      experimental-features = if useLix then [
        # 2024-11-17
        # https://git.lix.systems/lix-project/lix/src/branch/main/src/libutil/experimental-features
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "daemon-trust-override"
        "dynamic-derivations"
        "fetch-closure"
        "flakes"
        "impure-derivations"
        "nix-command"
        "no-url-literals"
        "parse-toml-timestamps"
        "pipe-operator"
        "read-only-local-store"
        "recursive-nix"
        "repl-automation"
        # "repl-flake.md"
      ] else [
        # 2024-07-24
        # https://github.com/NixOS/nix/blob/fb450de20ec8df558f9f7f167d748acf7cabe151/src/libutil/experimental-features.cc
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "configurable-impure-env"
        "daemon-trust-override"
        "dynamic-derivations"
        "fetch-closure"
        "fetch-tree"
        "flakes"
        "git-hashing"
        "impure-derivations"
        "local-overlay-store"
        "mounted-ssh-store"
        "nix-command"
        "no-url-literals"
        "parse-toml-timestamps"
        "pipe-operators"
        "read-only-local-store"
        "recursive-nix"
        "verified-fetches"
      ];
      # sandbox = "relaxed";
      sandbox = true;
      auto-allocate-uids = true;
      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;
      keep-build-log = true;
      pure-eval = false;
      use-cgroups = true;
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
    };
    optimise = {
      automatic = true;
    };
    sshServe = {
      protocol = "ssh-ng";
    };
    channel = {
      enable = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
    };
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  nix.settings.build-dir = buildTmpDir;
  systemd.services.nix-daemon.environment.TMPDIR = buildTmpDir;
  systemd.tmpfiles.rules = [
    "d ${buildTmpDir} 770 root nixbld"
  ];

}
