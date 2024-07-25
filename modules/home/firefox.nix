{ ... }:
let ffConfig = {
  # This module can be configured here, still extremely opinionated tho :p
  disable_telemetry = true; # Completely disable telemetry, studies, etc.
  # XXX: above option will still disable most telemetry even if set to false lmao (cause im lazy)
  doh = {                   # DNS-over-HTTPS Configuration
    enable = true;          # Enable DNS-Over-HTTPS (disabling will use the default system DNS)
    url = "https://doh.sandbox.opendns.com/dns-query"; # DOH url to use
  };
  disable_pocket = true;    # Disable Pocket (ew)
  enable_compact_ui = true; # Enable Compact Mode (deprecated)
  enable_https_only = true; # Enable HTTPS-only mode
  enable_legacy_css = true; # Enable legacy CSS customizations (aka userChrome.css)
  disable_prefetch = true;  # Disable prefetching (will be disabled by uBlock Origin anyway)
  accessibility = false;    # Accessibility (Disabling slightly improves rendering performance)
}; in {
  programs.firefox = {
    enable = true;
    policies = with ffConfig; {
      DisableFeedbackCommands = true;       # Disable the menus for reporting sites.
      DisableFirefoxStudies = disable_telemetry; # Disable Firefox studies (Shield).
      DisablePocket = disable_pocket;       # Remove Pocket in the Firefox UI.
      DisableTelemetry = disable_telemetry; # DisableTelemetry
      DisplayBookmarksToolbar = "always";   # Set the initial state of the bookmarks toolbar.
      FirefoxHome = { # Customize the Firefox Home page.
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = false;
      };
      FirefoxSuggest = { # Customize Firefox Suggest (US only).
        WebSuggestions = true;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = false;
      };
    };
    profiles.default = {
      settings = with ffConfig; {
        # Configure DoH
        "network.trr.mode" = if doh.enable then 2 else 5;
        "network.trr.custom_uri" = if doh.enable then doh.url else "";

        # Disable Accessibility
        "accessibility.force_disabled" = if accessibility then "0" else "1";

        # Disable OOBE/first-run experience
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "trailhead.firstrun.branches" = "nofirstrun-empty";
        "browser.aboutwelcome.enabled" = false;

        # Disable default browser check
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;

        # Enable CSS customization
        "toolkit.legacyUserProfileCustomizations.stylesheets" = enable_legacy_css;

        # Enable HTTPS-only mode
        "dom.security.https_only_mode" = enable_https_only;

        # Enable compact mode
        "browser.compactmode.show" = enable_compact_ui;
        "browser.uidensity" = if enable_compact_ui then 1 else 0;

        # Enable "Open previous windows and tabs" by default
        "browser.startup.page" = 3;

        # Enable "Highlight All" in search by default
        "findbar.highlightAll" = true;

        # Add more zoom values
        "toolkit.zoomManager.zoomValues" = ".3,.5,.67,.75,.8,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5";

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

        # Increase DNS cache size
        "network.dnsCacheEntries" = 4096;

        # Increase HTTP connection limit
        "network.http.max-connections" = 1500;
        "network.http.max-persistent-connections-per-server" = 10;

        # Disable prefetching
        # (disabled by uBlock by default anyway)
        "network.http.speculative-parallel-limit" = if disable_prefetch then 0 else 10;
        "network.dns.disablePrefetch" = disable_prefetch;
        "network.predictor.enabled" = !disable_prefetch;
        "network.prefetch-next" = !disable_prefetch;

        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Settings
        # - Enable the "Experimental" tab
        # - Hide "More from Mozilla" button
        "browser.preferences.experimental" = true;
        "browser.preferences.moreFromMozilla" = false;

        # Enable calculator in Firefox Suggest
        "browser.urlbar.suggest.calculator" = true;

        # Configure devtools
        "devtools.everOpened" = true;
        "devtools.toolbox.host" = "right";
        "devtools.toolbox.splitconsoleEnabled" = true;
        "devtools.selfxss.count" = 100;
        "devtools.webconsole.input.editorOnboarding" = false;
        "devtools.performance.new-panel-onboarding" = false;
        "devtools.performance.popup.intro-displayed" = true;

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

        # Disable add-on suggestions
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Disable Pocket
        "extensions.pocket.enabled" = !disable_pocket;

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
      };
    };
  };
}
