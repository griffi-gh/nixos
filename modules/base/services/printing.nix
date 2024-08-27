{ ... }: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    stateless = true;
    startWhenNeeded = true;
  };
}
