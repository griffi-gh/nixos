{ config, ... }:
{
  home.file.".local/share/applications/mimeapps.list" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/mimeapps.list";
  };
}
