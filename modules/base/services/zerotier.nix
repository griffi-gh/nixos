# { ... }: let
#   port = 9993;
# in {
#   services.zerotierone = {
#     enable = true;
#     inherit port;
#     joinNetworks = [
#       "9e1948db635b9d3e" # personal
#     ];
#   };
#   networking.firewall = {
#     allowedTCPPorts = [ port ];
#     allowedUDPPorts = [ port ];
#   };
# }
