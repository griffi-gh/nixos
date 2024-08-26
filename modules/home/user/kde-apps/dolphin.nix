{ ... }: {
  programs.plasma.configFile.dolphinrc = let
    immutable = value: { inherit value; immutable = true; };
  in {
    General = {
      GlobalViewProps = immutable false;
      ConfirmClosingMultipleTabs = immutable false;
      RememberOpenedTabs = immutable false;
      ShowFullPath = immutable true;
    };
  };
}
