{ pkgs, ... }: {
  # Enable TPM2 (Trusted Platform Module) support
  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
    pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
    tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  };
  # tss group has access to TPM devices
  users.users.user.extraGroups = [ "tss" ];
  environment.systemPackages = with pkgs; [
    tpm2-tools
    tpm2-tss
    tpm2-abrmd
    tpm2-pkcs11
  ];
}
