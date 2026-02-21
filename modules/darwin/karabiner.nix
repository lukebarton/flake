{ ... }: {
  launchd.daemons = {
    karabiner-vhiddaemon = {
      serviceConfig = {
        ProgramArguments = [
          "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
        ];
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
    karabiner-vhidmanager = {
      serviceConfig = {
        ProgramArguments = [
          "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
          "activate"
        ];
        RunAtLoad = true;
      };
    };
  };
}
