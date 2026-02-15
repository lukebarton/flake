{ ... }: {
  # Antinote default settings
  targets.darwin.defaults."com.chabomakers.Antinote" = {
    appIconPreference = "neither";
    #avgMainTrigger = "avg";
    #checkMainTrigger = "/x";
    #codeMainTrigger = "code";
    #countMainTrigger = "count";
    defaultLanguage = "typescript";
    hideWhenUnfocused = true;
    launchWithNewNote = false;
    #listMainTrigger = "list";
    #mathMainTrigger = "math";
    #paperOpacity = "subtle";
    #paperType = "blank";
    restorePinOnOpen = true;
    showFirstTimeSettings = false;
    #sumMainTrigger = "sum";
    #timerMainTrigger = "timer";
  };

  # Dato default settings
  targets.darwin.defaults."com.sindresorhus.Dato" = {
    createNewEventsWith = "googleCalendar";
    defaultEventDuration = "[97,10665824850173493248]";
    hourlyChimeSound = "AppSound - Cuckoo Pure";
    hourlyChime_isEnabled = true;
    iconInMenuBar = "dateInCalendar";
    menuBarTextSize = 14.0;
    menuBar_boldText = true;
    menuBar_iconAndTextSpacing = 0.0;
    menuBar_lowercase = false;
    menuBar_monospacedDigits = false;
    showDateInMenuBar = false;
    showMonthInMenuBar = false;
    showSecondsInMenuBar = false;
    showTimeInMenuBar = true;
    showWeekDayInMenuBar = true;
    upcomingEventInMenuBarDurationBefore = "[9367,9348261562630012928]";
    upcomingEventInMenuBarEventTitleLimit = 30;
    upcomingEventInMenuBarShowMinutesForMoreThanAnHour = true;
    upcomingEventInMenuBar_boldText = false;
    upcomingEventInMenuBar_humanFriendlyCountdown = true;
    upcomingEventInMenuBar_isEnabled = true;
    upcomingEventInMenuBar_menuItemAction = "showWindowWithEventDetails";
    upcomingEventInMenuBar_onlyEventsWithStatus = "acceptedAndTentativeAndPending";
    upcomingEventInMenuBar_showBackgroundOnActiveEvent = true;
    useGoogleMaps = true;
  };

  # Shottr default settings
  targets.darwin.defaults."cc.ffitch.shottr" = {
    #afterGrabCopy = false;
    #afterGrabSave = false;
    #afterGrabShow = true;
    allowTelemetry = false;
    #altZoomDirection = false;
    #alwaysOnTop = false;
    #areaCaptureMode = "editor";
    #areaCustomGrabber = false;
    #captureCursor = "auto";
    #colorFormat = "HEX";
    #copyOnEsc = true;
    #customBackdropColor = "#6080A0";
    #customGradFrom = "#221448";
    #customGradTo = "#919BD2";
    #defaultFolder = "";
    #downscaleOnSave = false;
    #expandableCanvas = true;
    #notificationType = "custom";
    #ocrRemoveBreaks = false;
    #preferLargeWindow = true;
    #primaryOCRLang = "en-US";
    #realPixels = false;
    #saveFormat = "Auto";
    #saveOnEsc = false;
    #scrollingManualEnabled = false;
    #scrollingMax = 20000;
    #scrollingReverseAutoscroll = false;
    #scrollingSpeed = 2;
    #snappingMode = 2;
    #thumbnailClosing = "manual";
    #uploadMode = "s3";
    KeyboardShortcuts_area = "{\"carbonModifiers\":768,\"carbonKeyCode\":21}";
    KeyboardShortcuts_fullscreen = "{\"carbonModifiers\":768,\"carbonKeyCode\":20}";
    KeyboardShortcuts_ocr = "{\"carbonKeyCode\":31,\"carbonModifiers\":6400}";
    windowShadow = "wallpaper";
    #windowSolidColor = "#404448";
  };

}
