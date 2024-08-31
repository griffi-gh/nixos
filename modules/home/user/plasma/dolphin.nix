{ ... }: {
  programs.plasma.configFile.dolphinrc = {
    General = {
      GlobalViewProps = false;
      ConfirmClosingMultipleTabs = false;
      RememberOpenedTabs = false;
      ShowFullPath = true;
    };
  };
}
