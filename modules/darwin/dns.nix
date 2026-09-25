{ ... }: {
  # Scoped resolver: send home.innerspace.sh queries to the Twingate nameservers
  # (macOS reads /etc/resolver/<domain> and uses it only for that domain).
  environment.etc."resolver/home.innerspace.sh".text = ''
    nameserver 100.95.0.251
    nameserver 100.95.0.252
    nameserver 100.95.0.253
    nameserver 100.95.0.254
  '';
}
