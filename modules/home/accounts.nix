{ inputs, ... }: let
    thunderbird_oauth = {
        thunderbird = {
            enable = true;
            settings = id: let OAuth2 = 10; in {
                "mail.smtpserver.smtp_${id}.authMethod" = OAuth2;
                "mail.server.server_${id}.authMethod" = OAuth2;
                "mail.server.server_${id}.autosync_max_age_days" = 30;
                "mail.server.server_${id}.cleanupBodies" = true;
                "mail.server.server_${id}.daysToKeepBodies" = 30;
                "mail.server.server_${id}.daysToKeepHdrs" = 30;
            };
        };
    };
in {
    accounts.email.accounts = import "${inputs.private}/accounts.nix" {
        inherit thunderbird_oauth;
    };
}
