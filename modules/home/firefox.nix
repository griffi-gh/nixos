{ ... }:  {
  programs.firefox = {
    enable = true;
    policies = {
      # Disable the menus for reporting sites.
      DisableFeedbackCommands = true;

      # Set the initial state of the bookmarks toolbar:
      DisplayBookmarksToolbar = "always";

      # Customize Firefox Suggest (US only).
      FirefoxSuggest = {
        Locked = true;
        WebSuggestions = true;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      # Remove Pocket in the Firefox UI.
      DisablePocket = true;

      # Disable Firefox studies (Shield).
      DisableFirefoxStudies = true;

      # DisableTelemetry
      DisableTelemetry = true;

      # Customize the Firefox Home page.
      FirefoxHome = {
        Locked = true;
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      # Disable the built-in password manager.
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
    };
    profiles.default = {
      settings = {
        # Make configured extensions work
        "extensions.autoDisableScopes" = 0;

        # Allow unsigned extensions
        # "xpinstall.signatures.required" = false;

        # Configure DoH
        # "network.trr.mode" = 2;
        # "network.trr.uri" = "https://doh.sandbox.opendns.com/dns-query";
        # "network.trr.custom_uri" = "https://doh.sandbox.opendns.com/dns-query";

        # Use system DNS
        "network.trr.mode" = 5;

        # Disable Accessibility
        "accessibility.force_disabled" = "1";

        # Disable OOBE/first-run experience
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "trailhead.firstrun.branches" = "nofirstrun-empty";
        "browser.aboutwelcome.enabled" = false;

        # Disable default browser check
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;

        # Enable CSS customization
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Enable HTTPS-only mode
        "dom.security.https_only_mode" = true;

        # Enable compact mode
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;

        # Enable WebRender on all devices
        "gfx.webrender.all" = true;

        # Set content blocking to "Strict"
        "browser.contentblocking.category" = "strict";

        # Enable tracking protection
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # Enable fingerprinting protection
        "privacy.fingerprintingProtection" = true;

        # Enable query stripping
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;

        # Enable GPC and DNT header
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;

        # Disable prefetching
        # (disabled by uBlock by default anyway)
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;

        # Disable Google Safe Browsing
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
        "browser.safebrowsing.provider.google.gethashURL" = "";
        "browser.safebrowsing.provider.google.updateURL" = "";
        "browser.safebrowsing.provider.google4.dataSharingURL" = "";
        "browser.safebrowsing.provider.google4.gethashURL" = "";
        "browser.safebrowsing.provider.google4.updateURL" = "";

        # Disable Pocket
        "extensions.pocket.enabled" = false;

        # Disable activitystream pocket/sponsored stuff/telemetry
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint" = "";
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # Opt out of Studies
        "app.shield.optoutstudies.enabled" = true;

        # Disable Normandy (related to studies)
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;

        # Disable ping centre telemetry
        "browser.ping-centre.telemetry" = false;

        # Disable "coverage" ping
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";

        # Disable telemetry stuff
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Disable Beacon (telemetry)
        "beacon.enabled" = false;

        # Disable discovery (telemetry)
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" = false;

        # Disable Breakpad (crash reporting)
        "breakpad.reportURL" = "";

        # Disable health reporting
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

        # Preferences - Enable the "Experimental" tab
        "browser.preferences.experimental" = true;

        # Preferences - Hide "More from Mozilla" button
        "browser.preferences.moreFromMozilla" = false;

        # Misc. stuff

        # Disable "privacy-preserving" attribution (ad measurement)
        "dom.private-attribution.submission.enabled" = false;

        # Use OS locale(s)
        "intl.regional_prefs.use_os_locales" = true;

        # Enable "Open previous windows and tabs" by default
        "browser.startup.page" = 3;

        # Enable "Highlight All" in search by default
        "findbar.highlightAll" = true;

        # Add more zoom values
        "toolkit.zoomManager.zoomValues" = ".3,.5,.67,.75,.8,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5";

        # Increase DNS cache size
        "network.dnsCacheEntries" = 4096;

        # Increase HTTP connection limit
        "network.http.max-connections" = 1500;
        "network.http.max-persistent-connections-per-server" = 10;

        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Enable calculator in Firefox Suggest
        "browser.urlbar.suggest.calculator" = true;

        # Configure devtools
        "devtools.everOpened" = true;      # Enable Inspect accs. etc
        "devtools.toolbox.host" = "right"; # Dock panel to the right
        "devtools.toolbox.splitconsoleEnabled" = true; # Enable js console at the bottom
        "devtools.selfxss.count" = 100; # (Disable paste protection)
        "devtools.webconsole.input.editorOnboarding" = false;
        # Skip onboarding popups on the "Performace" tab:
        "devtools.performance.new-panel-onboarding" = false;
        "devtools.performance.popup.intro-displayed" = true;

        # Disable add-on suggestions: (using Google Analytics)
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Prevent trans panel from popping up during first use
        "browser.translations.panelShown" = true;

        # Disable Firefox Relay feature
        "signon.firefoxRelay.feature" = false;

        # Disable password breach alerts
        "signon.management.page.breach-alerts.enabled" = false;

        # Enable "Block new requests asking to allow notifications"
        "permissions.default.desktop-notification" = 2;

        # Disable the built-in password manager
        "pref.privacy.disable_button.view_passwords" = true;
        "signon.rememberSignons" = false;

        # Disable upgrade pages
        "browser.startup.homepage_override.mstone" = "ignore";

        # Use Mozilla location services
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
      };
    };
  };
}
