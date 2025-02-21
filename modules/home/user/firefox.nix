{ pkgs, ... }:  {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = {
        pipewireSupport = true;
        ffmpegSupport = true;
      };
    };
    nativeMessagingHosts = with pkgs; [
      kdePackages.plasma-browser-integration
    ];
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
      userChrome = ''
        @-moz-document url("chrome://browser/content/browser.xhtml") {
          /* Allow shrinking below the minimum window size */
          #main-window {
            min-width: 300px !important;
          }
          @media (max-width: 400px) {
            #urlbar-container {
              min-width: 80px !important;
              flex-basis: 80px !important;
            }

            #identity-box,
            #tracking-protection-icon-container,
            #cookie-button,
            #reader-mode-button,
            #picture-in-picture-button {
              display: none !important;
            }
          }

          /* Change the tab style */
          /* tab[selected="true"] .tab-background {
            border-bottom: none;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
            transform: translateY(0.3rem) scaleY(1.4);
          }
          tab[selected="true"] .tab-background {
            border-top: 2px solid #a9858d;
            background: #4a4d50 !important;
          }
        }; */
      '';
      settings = {
        # Make configured extensions work
        "extensions.autoDisableScopes" = 0;

        # Enable overscroll (middle click to scroll)
        "general.autoScroll" = 1;

        # touchpad/scroll
        "apz.overscroll.enabled" = 1;
        "apz.gtk.kinetic_scroll.enabled" = true;
        "apz.gtk.pangesture.delta_mode" = 2;
        "apz.gtk.pangesture.pixel_delta_mode_multiplier" = 50.0;

        # gtk tweaks
        "widget.gtk.legacy-cursors.enabled" = true;
        "widget.gtk.non-native-titlebar-buttons.enabled" = false;

        # Enable Hover-Preview
        "browser.tabs.hoverPreview.enabled" = true;

        # Allow unsigned extensions
        # "xpinstall.signatures.required" = false;

        # Configure DoH
        # "network.trr.mode" = 2;
        # "network.trr.uri" = "https://doh.sandbox.opendns.com/dns-query";
        # "network.trr.custom_uri" = "https://doh.sandbox.opendns.com/dns-query";

        # Always use system DNS (and do not change automatically)
        "network.trr.mode" = 5;

        # Prefer IPv6 DNS
        "network.dns.preferIPv6" = true;

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
        "gfx.webrender.batched-texture-uploads" = true;
        "gfx.webrender.compositor" = true; # Use native WL compositor
        "gfx.webrender.compositor.force-enabled" = true;
        "gfx.webrender.fallback.software" = false; # Disable software fallback
        # Enable shader caching:
        "gfx.webrender.program-binary-disk" = true;
        "gfx.webrender.precache-shaders" = true;

        # Enable hw accel for video decoding
        "media.hardware-video-decoding.force-enabled" = true;
        "media.ffmpeg.encoder.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;

        # Enable hw accel for PDF (!!! may actually be slower, e.g. w/ most dedicated gpus)
        "pdfjs.enableHWA" = true;

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
        "browser.newtabpage.activity-stream.telemetry.ut.events" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # Disable ff account telemetry
        "identity.fxaccounts.telemetry.clientAssociationPing.enabled" = false;

        # Opt out of Studies
        "app.shield.optoutstudies.enabled" = true;

        # Disable Normandy (related to studies)
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;

        # Disable ping centre telemetry
        "browser.ping-centre.telemetry" = false;

        # Disable "coverage" and "user_characteristics_ping" ping
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.telemetry.user_characteristics_ping.opt-out" = true;
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

        # Use XDG desktop portals
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.location" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;

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
        # "permissions.default.desktop-notification" = 2;

        # Disable the built-in password manager
        "pref.privacy.disable_button.view_passwords" = true;
        "signon.rememberSignons" = false;

        # Disable upgrade pages
        "browser.startup.homepage_override.mstone" = "ignore";

        # Use BeaconDB for geolocation
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";

        # Enable AI thingy
        "browser.ml.chat.enabled" = true;
        "browser.ml.chat.hideLocalhost" = false;
        "browser.ml.chat.sidebar" = true;
        "browser.ml.chat.shortcuts" = false;
        "browser.ml.chat.provider" = "https://chatgpt.com";

        # Enable Chromium Widevine CDM, and use beta versions
        "media.gmp-widevinecdm.force-chromium-update" = true;
        "media.gmp-widevinecdm.force-chromium-beta" = true;

        # tab groups
        "browser.tabs.groups.enabled" = true;
      };
    };
  };
}
