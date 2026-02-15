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

}
