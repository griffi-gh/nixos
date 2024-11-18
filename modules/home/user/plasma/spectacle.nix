{ ... }: {
  programs.plasma.configFile.spectaclerc = {
    General.autoSaveImage = true;
    General.clipboardGroup = "PostScreenshotCopyImage";
    General.launchAction = "UseLastUsedCapturemode";
    VideoSave.preferredVideoFormat = 2;
  };
}
