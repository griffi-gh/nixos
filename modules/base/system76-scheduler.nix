{ ... }: {
  # enable system76 scheduler
  # TODO: prioritize plasmashell, kwin and KRunner
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
  };
}