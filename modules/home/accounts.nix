{ ... }: let
    gmail = {
        flavor = "gmail.com";
        smtp = {
            host = "smtp.gmail.com";
            port = 587;
            tls = {
                enable = true;
                useStartTls = true;
            };
        };
        imap = {
            host = "imap.gmail.com";
            port = 993;
            tls.enable = true;
        };
    };
    thunderbird = {
        thunderbird = {
            enable = true;
            settings = id: {
                "mail.server.server_${id}.autosync_max_age_days" = 30;
                "mail.server.server_${id}.cleanupBodies" = true;
                "mail.server.server_${id}.daysToKeepBodies" = 30;
                "mail.server.server_${id}.daysToKeepHdrs" = 30;

                # THIS IS GMAIL-SPECIFIC
                "mail.server.server_${id}.is_gmail" = true;
                "mail.server.server_${id}.oauth2.issuer" = "accounts.google.com";
                "mail.server.server_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
            };
        };
    };
in {
    accounts.email.accounts = {
        "prasol258@gmail.com" = {
            primary = true;
            address = "prasol258@gmail.com";
            realName = "Alex Prasol";
        } // gmail // thunderbird;
    };
}
