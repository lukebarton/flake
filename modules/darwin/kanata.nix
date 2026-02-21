{ pkgs, inputs, ... }: {
  launchd.daemons.kanata = {
    command = "${pkgs.kanata}/bin/kanata -c ${inputs.self + "/files/kanata/kanata.kbd"}";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      StandardErrorPath = "/Library/Logs/Kanata/kanata.err.log";
      StandardOutPath = "/Library/Logs/Kanata/kanata.out.log";
    };
  };

  # Log rotation for kanata
  environment.etc."newsyslog.d/kanata.conf".text = ''
    /Library/Logs/Kanata/kanata.err.log 644 3 100 * J
    /Library/Logs/Kanata/kanata.out.log 644 3 100 * J
  '';
}
