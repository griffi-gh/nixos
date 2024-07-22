{ config, lib, pkgs, ... }: {
  nix = {
    package = pkgs.nixVersions.git;
    settings = {
      # All Experimental Features on as of April 26th, 2024
      experimental-features = [
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
        "read-only-local-store"
        "recursive-nix"
        "verified-fetches"
      ];
      auto-allocate-uids = true;
      auto-optimise-store = true;
      keep-build-log = false;
      keep-derivations = false;
      keep-outputs = false;
      pure-eval = false;
      sandbox = true;
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
