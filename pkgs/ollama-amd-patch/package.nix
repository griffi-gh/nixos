{
  ollama-rocm,
  fetchFromGitHub,
  symlinkJoin,
  makeWrapper,
  ...
}:

let
  ollama' = ollama-rocm.overrideAttrs(finalAttrs: previousAttrs: {
    src = fetchFromGitHub {
      owner = "Maciej-Mogilany";
      repo = "ollama";
      # AMD_APU_GTT_memory
      rev = "8170b0345de6aa78c679c9eae303fbf745f5bd7f";
      hash = "sha256-Q9ML6ADKgsVDEbyljX8G/8i41jkd23Hl+rAX+t0mUfg=";
    };
    vendorHash = "sha256-1uk3Oi0n4Q39DVZe3PnZqqqmlwwoHmEolcRrib0uu4I=";
  });
in

symlinkJoin {
  name = "ollama-amd-patch";
  paths = [ ollama' ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/ollama \
      --set-default HSA_OVERRIDE_GFX_VERSION "11.0.1"
  '';
}