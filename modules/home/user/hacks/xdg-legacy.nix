{ config, ... }: {
  home.file.".local/share/applications/mimeapps.list" = {
    source = config.lib.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/mimeapps.list";
  };
}