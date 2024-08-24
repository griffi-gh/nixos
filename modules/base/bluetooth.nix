{ ... }: {
  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # should this be on? (iirc kde can manage this?)
    settings = {
      General = {
        Experimental = true; # enable battery level reporting
        KernelExperimental = true;
        Enable = "Source,Sink,Media,Socket"; # enable a2dp sink
      };
    };
  };
}
