{ ... }: {
  location.provider = "geoclue2";
  services.geoclue2 = {
    enable = true;
    # appConfig = let
    #   allowed = { isAllowed = true; isSystem = false; };
    #   allowed-system = { isAllowed = true; isSystem = true; };
    # in {
    #   localtimed = allowed-system;
    #   firefox = allowed;
    # };
  };
}
