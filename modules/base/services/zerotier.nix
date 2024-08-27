{ ... }: {
  services.zerotierone = {
    enable = true;
    port = 9993;
    joinNetworks = [
      "9e1948db635b9d3e" # personal
    ];
  };
}
