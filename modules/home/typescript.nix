{ pkgs, ... }: {
  home.packages = [
    pkgs.bun
    pkgs.typescript
  ];
}
