{ config, lib, pkgs, ... }: {
  boot = {
    kernelParams = [
      "radeon.si_support=0"
      "radeon.cik_support=0"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
    ];
    initrd.kernelModules = [
      "amdgpu"
      "radeon"
    ];
  };
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
