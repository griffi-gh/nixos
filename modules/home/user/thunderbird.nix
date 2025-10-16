{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
    profiles.default = {
      isDefault = true;
      withExternalGnupg = true;
      settings = {
        #TODO fill this out :p

        # Allow remote content (idc about privacy that much)
        # "mailnews.message_display.disable_remote_image" = false;

        # Set chat theme to dark
        "messenger.options.messagesStyle.variant" = "Dark";

        # Enable dark reader for web content (Experimental)
        "mail.dark-reader.enabled" = true;

        # Toolbar extensions: only show icons, not labels
        "toolbar.unifiedtoolbar.buttonstyle" = 2;

        # Disable startpage
        "mailnews.start_page.enabled" = false;

        # Set the default sort order to descending by date received.
        "mailnews.default_sort_type" = 18;
        "mailnews.default_sort_order" = 2;

        # Increase amount of visible hours in calendar from 9 to 12
        "calendar.view.visiblehours" = 12;

        # autosync
        "mail.server.default.autosync_max_age_days" = 30;

        # e2ee stuff
        "mail.e2ee.auto_enable" = true;
        "mail.e2ee.auto_disable" = true;

        # Make configured extensions work
        "extensions.autoDisableScopes" = 0;

        # Allow unsigned extensions
        "xpinstall.signatures.required" = false;

        # spam stuff
        "mail.spam.manualMark" = true;
        "mail.spam.markAsReadOnSpam" = true;

        # Enable search integration
        # "searchintegration.enabled" = true;

        # hide donation page
        "app.donation.eoy.version.viewed" = 999;

        # hide "know your rights" popup
        "mail.rights.override" = true;

        # disable UI instrumentation
        "mail.instrumentation.postUrl" = "";
        "mail.instrumentation.askUser" = false;
        "mail.instrumentation.userOptedIn" = false;

        # TODO: these are mostly shared with Firefox:

        # gtk tweaks
        "widget.gtk.legacy-cursors.enabled" = true;
        "widget.gtk.non-native-titlebar-buttons.enabled" = false;

        # touchpad/scroll
        "apz.overscroll.enabled" = 1;
        "apz.gtk.kinetic_scroll.enabled" = true;
        "apz.gtk.pangesture.delta_mode" = 2;
        "apz.gtk.pangesture.pixel_delta_mode_multiplier" = 50.0;

        # Disable accessibility
        "accessibility.force_disabled" = 1;

        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Use Mozilla location services
        "geo.provider.network.url" =
          "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";

        # Disable telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

        # Disable Telemetry Coverage
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";

        # Disable ping center telemetry
        "browser.ping-centre.telemetry" = false;

        # Disable Normandy
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # Disable addon suggestions
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Use XDG desktop portals
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.location" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;

        # Enable hw accel for video
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffmpeg.encoder.enabled" = true;
      };
    };
  };
}
