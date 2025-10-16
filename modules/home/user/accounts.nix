{ lib, ... }:
let
  thunderbird =
    {
      login ? true,
      check ? login,
      oauth ? true,
    }:
    {
      thunderbird = {
        enable = true;
        settings =
          id:
          (
            {
              "mail.server.server_${id}.autosync_max_age_days" = 30;
              "mail.server.server_${id}.cleanupBodies" = true;
              "mail.server.server_${id}.daysToKeepBodies" = 30;
              "mail.server.server_${id}.daysToKeepHdrs" = 30;
              "mail.server.server_${id}.login_at_startup" = login;
              "mail.server.server_${id}.check_new_mail" = check;
            }
            // (
              if oauth then
                (
                  let
                    OAuth2 = 10;
                  in
                  {
                    "mail.smtpserver.smtp_${id}.authMethod" = OAuth2;
                    "mail.server.server_${id}.authMethod" = OAuth2;
                  }
                )
              else
                { }
            )
          );
      };
    };
  emailAccounts = import ../../../secrets/emailAccounts.nix { inherit thunderbird; };
in
{
  accounts.email.accounts = lib.listToAttrs (
    map (item: {
      name = item.address;
      value = item;
    }) emailAccounts
  );

  # Set the list of email accounts to be used by Thunderbird.
  # (this allows setting the order explicitly, and works around a bug in home-manager that keeps adding accounts to the list)
  programs.thunderbird.profiles.default.settings =
    let
      toHashedName = x: "account_" + (builtins.hashString "sha256" x);
      tbAccounts = map (item: item.address) emailAccounts;
    in
    {
      "mail.accountmanager.accounts" = lib.concatStringsSep "," (
        (map toHashedName tbAccounts) ++ [ "account1" ]
      );
    };
}
