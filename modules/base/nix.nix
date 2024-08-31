{ pkgs, ... }: {
  nix = {
    package = pkgs.nixVersions.latest; # pkgs.nixVersions.git
    settings = {
      # See https://nixos.org/manual/nix/stable/command-ref/conf-file.html
      # for a complete list of Nix configuration options.

      # 2024-07-24
      # https://github.com/NixOS/nix/blob/fb450de20ec8df558f9f7f167d748acf7cabe151/src/libutil/experimental-features.cc
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
