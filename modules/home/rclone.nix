{ pkgs, ... }: {

  # rclone config file
  home.file.".config/rclone/rclone.conf".source = ../../files/rclone/rclone.conf;

  # rclone secrets
  programs.zsh.sessionVariables = {
    RCLONE_CONFIG_DRIME_ACCESS_TOKEN = "op://dev/rclone/drime-token";
    RCLONE_CONFIG_DROPBOX_TOKEN = "op://dev/rclone/dropbox-token";
    RCLONE_CONFIG_FILEN_API_KEY = "op://dev/rclone/filen-token-obscured";
    RCLONE_CONFIG_FILEN_PASSWORD = "op://dev/rclone/filen-password-obscured";
  };

  # Use in conjunction with the `op-zsh` alias
  programs.zsh.shellAliases = {
    cloud-pull-destructively = ''rclone sync cloud: ~/cloud --filter-from ~/.config/rclone/cloud.filters --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
    cloud-push = ''rclone sync ~/cloud cloud: --filter-from ~/.config/rclone/cloud.filters --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
    keystone-sync = ''rclone sync cloud: keystone:/cloud --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
  };
}
