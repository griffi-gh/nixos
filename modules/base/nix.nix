{ config, lib, pkgs, ... }: {
  nix = {
    package = pkgs.nixVersions.git;
    settings = {
      # See https://nixos.org/manual/nix/stable/command-ref/conf-file.html
      # for a complete list of Nix configuration options.

      # 2024-07-24
      # https://github.com/NixOS/nix/blob/fb450de20ec8df558f9f7f167d748acf7cabe151/src/libutil/experimental-features.cc
      experimental-features = [
        "ca-derivations"
        "impure-derivations"
        "flakes"
        "fetch-tree"
        "nix-command"
        "git-hashing"
        "recursive-nix"
        "no-url-literals"
        "fetch-closure"
        "auto-allocate-uids"
        "cgroups"
        "daemon-trust-override"
        "dynamic-derivations"
        "parse-toml-timestamps"
        "read-only-local-store"
        "local-overlay-store"
        "configurable-impure-env"
        "mounted-ssh-store"
        "verified-fetches"
      ];

      sandbox = "relaxed";
      auto-allocate-uids = true;
      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;
      keep-build-log = false;
      pure-eval = false;
      use-cgroups = true;
      use-xdg-base-directories = true;
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
}
