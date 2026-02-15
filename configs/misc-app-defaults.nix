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
}