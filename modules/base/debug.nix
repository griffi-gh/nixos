{ pkgs, ... }:
{
  services.nixseparatedebuginfod2.enable = true; # Debug symbols

  # system debugging tools
  # (must be installed system-wide for nixseparatedebuginfod to work?)
  environment.systemPackages = with pkgs; [
    gdb
    strace
    (elfutils.override { enableDebuginfod = true; })
    bpftrace
  ];
}
