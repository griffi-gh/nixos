{ ... }:
{
  location.provider = "geoclue2";
  services.geoclue2 = {
    enable = true;
    geoProviderUrl = "https://beacondb.net/v1/geolocate";
    submissionUrl = "https://beacondb.net/v2/geosubmit";
    # geoProviderUrl = "https://beacondb.net/v1/geolocate";
    # submissionNick = "geoclue";
    # enable3G = false;
    # enableCDMA = false;
    # enableModemGPS = true;
    # enableNmea = true;
    # enableWifi = true;
  };
}
