{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions;
          from-openvsx = vscode-extensions.open-vsx; in
      with vscode-extensions.vscode-marketplace;
    [
      # C#/dotnet
      from-nixpkgs.ms-dotnettools.csdevkit
      from-nixpkgs.ms-dotnettools.csharp
      from-nixpkgs.ms-dotnettools.vscode-dotnet-runtime
      ms-dotnettools.dotnet-maui

      # IntelliCode support for C# DevKit
      from-nixpkgs.ms-dotnettools.vscodeintellicode-csharp
    ];
    userSettings = {
      # C#:
      "dotnetAcquisitionExtension.enableTelemetry" = false;
      "dotnetAcquisitionExtension.installTimeoutValue" = 0;
      "csharp.preview.improvedLaunchExperience" = true;
      "csharp.experimental.debug.hotReload" = true;
      "nuget.includePrereleasePackageVersions" = true;
      "csharp.inlayHints.enableInlayHintsForImplicitObjectCreation" = true;
      "csharp.inlayHints.enableInlayHintsForImplicitVariableTypes" = true;
      "csharp.inlayHints.enableInlayHintsForLambdaParameterTypes" = true;
      "csharp.inlayHints.enableInlayHintsForTypes" = true;
      "dotnet.inlayHints.enableInlayHintsForIndexerParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForLiteralParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForObjectCreationParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForOtherParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForParameters" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatDifferOnlyBySuffix" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatMatchArgumentName" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatMatchMethodIntent" = true;
    };
  };
}