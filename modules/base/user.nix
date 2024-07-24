{ config, lib, pkgs, ... }: {
  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialHashedPassword = "$y$j9T$rBfGrT8nzukk5Uh7KQ31u/$v8AXjUZXGwWYfc2Pve/Sx84LRAeRLGyKs7fh8br4Uv2"; #change
    packages = with pkgs; [
      htop
      tree
      glxinfo
      nushell
      firefox
      thunderbird
      blender
      principia
      galaxy-buds-client
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      # dell-pc
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0+5R7zCfIIeMERNyNJIJ1qrBoxfcMP4WRzK0IQHOGHacAsPU8XV7oGXL/wXdD7O/lQm6znjQ44dU7AfCWM42odCc9mep0SH9Z911syC0GJue///i6EAlfQJoZIUP3Fb7z0uDl6zdZ01g0xp6dhXCOKc7Jqgy6esZS0y1nXs2DZyNe1C/RnD5rStdtfN4a4qN6U2FlC8Lb4MJfysRt+K+otLOAjs3Fby/dYwVazco+bykFK8/DhjmE2WvnF6+rKi4/og+Y9uRgPP6k0sfN1ogT6KRPkIKfjFn59WCCdN8W/7hButNCBIlXFYABxcDD5zlw5EZHt1qPI9bitmH1JJB6Vn4DbkmOgffxedifTvtgft8t1Ld5gIO5XwofpQ3wvS8o1M2hIBw3p3/9XC+jMXe0rztIog8Im9CbZJXWP3jZE3V2Q/NhmCRUUNAkF1bI76//wvrJe0KOi2b7E2gXapCppNTqTNUfMajr7NP0uW8BoYt2Oj6YB78sVv2NtosNqqM= user@dell-pc"
      # phone termux
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFWfqwIKwAjzx3WbJc0pYcJllV0BIpJSf9vm3lM8Ubl u0_a371@localhost"
    ];
  };
}
