{ ... }:
{
  programs.plasma.configFile.spectaclerc = {
    General.autoSaveImage = true;
    General.clipboardGroup = "PostScreenshotCopyImage";
    General.launchAction = "DoNotTakeScreenshot";
    VideoSave.preferredVideoFormat = 2;
  };
}
