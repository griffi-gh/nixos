{ pkgs, ... }:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    stateless = true;
    startWhenNeeded = true;
    drivers = with pkgs; [
      gutenprint
    ];
    # canon-cups-ufr2, cnijfilter?
  };
}
