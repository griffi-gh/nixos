# Over-Engineered Firefox Module (tm)

{ ... }: let ffConfig = {
  # This module can be configured below:
  doh = {                        # DNS-over-HTTPS Configuration
    enable = true;               # Enable DNS-Over-HTTPS (disabling will use the default system DNS)
    url = "https://doh.sandbox.opendns.com/dns-query"; # DOH url to use (defaults to Cloudflare if left empty)
  };
  disable_telemetry = true;      # Completely disable telemetry, studies and crash reports
  disable_safebrowsing = true;   # Disable Google Safe Browsing (and prevent downloading blocklists from Google)
  disable_browser_check = true;  # Disable default browser check
  skip_oobe = true;              # Skip the first-run experience (about:welcome)
  disable_pocket = true;         # Disable Pocket (ew)
  force_webrender = true;        # Force-enable webrender, even on unsupported hardware
  privacy_strict = true;         # Enable strict privacy options
  enable_compact_ui = true;      # Enable Compact Mode (deprecated)
  enable_https_only = true;      # Enable HTTPS-only mode
  enable_legacy_css = true;      # Enable legacy CSS customizations (aka userChrome.css)
  disable_prefetch = true;       # Disable prefetching (will be disabled by uBlock Origin anyway)
  accessibility = false;         # Accessibility (Disabling slightly improves rendering performance)
  bookmark_toolbar = "always";   # Set the initial state of the bookmarks toolbar ("always"/"never"/"newtab")
  about.newtab = {               # Customize the "about:newtab" screen (aka Home)
    enable = true;               # Enable homescreen customizations (if set to false, options below will be ignored)
    locked = true;               # Prevent modification from Firefox UI (default: true)
    shown = {                    # Select which items to show
      Search = true;             # Show the search bar
      TopSites = false;          # Show pinned websites
      SponsoredTopSites = false; # - Include "sponsored" tiles (ads)
      Highlights = false;        # Show highlights
      Pocket = false;            # Show pocket
      SponsoredPocket = false;   # - Show "sponsored" pocket stuff (ads)
      Snippets = false;          # Show tips from Mozilla
    };
  };
  about.preferences = {          # Customize the "about:preferences" screen (aka Settings)
    show_experimental = true;    # Show "Firefox Experiments" tab in preferences, even on Stable
    hide_morefrommozilla = true; # Hide "More from Mozilla" ad from the preferences screen
  };
}; in {
  programs.firefox = {
    enable = true;
    policies = with ffConfig; (
      {
        # Disable the menus for reporting sites.
        DisableFeedbackCommands = true;

        # Set the initial state of the bookmarks toolbar:
        DisplayBookmarksToolbar = ffConfig.bookmark_toolbar or "newtab";

        # Customize Firefox Suggest (US only).
        FirefoxSuggest = {
          WebSuggestions = true;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = false;
        };
      }

      // (if disable_pocket then {
        # Remove Pocket in the Firefox UI.
        DisablePocket = true;
      } else {})

      // (if disable_telemetry then {
        DisableFirefoxStudies = true; # Disable Firefox studies (Shield).
        DisableTelemetry = true;      # DisableTelemetry
      } else {})

      // (if about.newtab.enable then {
        # Customize the Firefox Home page.
        FirefoxHome = {
          Search = about.newtab.shown.Search or false;
          TopSites = about.newtab.shown.TopSites or false;
          SponsoredTopSites = about.newtab.shown.SponsoredTopSites or false;
          Highlights = about.newtab.shown.Highlights or false;
          Pocket = about.newtab.shown.Pocket or false;
          SponsoredPocket = about.newtab.shown.SponsoredPocket or false;
          Snippets = about.newtab.shown.Snippets or false;
          Locked = about.newtab.locked or true;
        };
      } else {})
    );
    profiles.default = {
      settings = with ffConfig; (
        (if doh.enable then let
          doh_url = doh.url or "https://cloudflare-dns.com/dns-query";
        in {
          # Configure DoH
          "network.trr.mode" = 2;
          "network.trr.uri" = doh_url;
          "network.trr.custom_uri" = doh_url;
        } else {
          # Use system DNS
          "network.trr.mode" = 5;
        })

        // (if !accessibility then {
          # Disable Accessibility
          "accessibility.force_disabled" = "1";
        } else {})

        // (if skip_oobe then {
          # Disable OOBE/first-run experience
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "trailhead.firstrun.branches" = "nofirstrun-empty";
          "browser.aboutwelcome.enabled" = false;
        } else {})

        // (if disable_browser_check then {
          # Disable default browser check
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
        } else {})

        // (if enable_legacy_css then {
          # Enable CSS customization
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        } else {})

        // (if enable_https_only then {
          # Enable HTTPS-only mode
          "dom.security.https_only_mode" = true;
        } else {})

        // (if enable_compact_ui then {
          # Enable compact mode
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1;
        } else {})

        // (if force_webrender then {
          # Enable WebRender on all devices
          "gfx.webrender.all" = true;
        } else {})

        // (if privacy_strict then {
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
        } else {})

        // (if disable_prefetch then {
          # Disable prefetching
          # (disabled by uBlock by default anyway)
          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
        } else {})

        // (if disable_safebrowsing then {
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
        } else {})

        // (if disable_pocket then {
          # Disable Pocket
          "extensions.pocket.enabled" = !disable_pocket;
        } else {})

        // (if disable_telemetry then {
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
        } else {})

        // (if about.preferences.show_experimental then {
          # Preferences - Enable the "Experimental" tab
          "browser.preferences.experimental" = true;
        } else {})

        // (if about.preferences.hide_morefrommozilla then {
          # Preferences - Hide "More from Mozilla" button
          "browser.preferences.moreFromMozilla" = false;
        } else {})

        // {
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
        }
      );
    };
  };
}
