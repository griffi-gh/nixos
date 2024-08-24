{ pkgs, ... }: {
  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ];
    # make sure to change it after install:
    initialHashedPassword = "$y$j9T$rBfGrT8nzukk5Uh7KQ31u/$v8AXjUZXGwWYfc2Pve/Sx84LRAeRLGyKs7fh8br4Uv2";
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      # a52s
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFWfqwIKwAjzx3WbJc0pYcJllV0BIpJSf9vm3lM8Ubl u0_a371@localhost"
      # asus-pc
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID7VB6Mohz6Zo0ygBpdhuKinxELomEXUyQzdyLd5u00M prasol258@gmail.com"
      # dell-pc
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeD5o9/2cpH7HaP4PldZYKgJnltFX9XlC5bvcxpOivq user@dell-pc"
    ];
  };
}
