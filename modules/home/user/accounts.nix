{ lib, inputs, ... }: let
  thunderbird = { login ? true }: {
    thunderbird = {
      enable = true;
      settings = id: let OAuth2 = 10; in {
        "mail.smtpserver.smtp_${id}.authMethod" = OAuth2;
        "mail.server.server_${id}.authMethod" = OAuth2;
        "mail.server.server_${id}.autosync_max_age_days" = 30;
        "mail.server.server_${id}.cleanupBodies" = true;
        "mail.server.server_${id}.daysToKeepBodies" = 30;
        "mail.server.server_${id}.daysToKeepHdrs" = 30;
        "mail.server.server_${id}.login_at_startup" = login;
      };
    };
  };
in {
  accounts.email.accounts = lib.listToAttrs (
    map (item: { name = item.address; value = item; })
    (import ../../../secrets/accounts.nix { inherit thunderbird; })
  );
}
