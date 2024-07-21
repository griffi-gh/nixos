{ config, lib, pkgs, ... }: {
  users.users.user = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    initialHashedPassword = "$y$j9T$rBfGrT8nzukk5Uh7KQ31u/$v8AXjUZXGwWYfc2Pve/Sx84LRAeRLGyKs7fh8br4Uv2"; #change
    packages = with pkgs; [
      tree
      glxinfo
      firefox
      thunderbird
      blender
      principia
      galaxy-buds-client
    ];
    shell = pkgs.nushell;
  };
}
