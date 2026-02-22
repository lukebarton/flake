{ pkgs, ... }: {

  # rclone config file
  home.file.".config/rclone/rclone.conf".source = ../../files/rclone/rclone.conf;

  home.file.".config/rclone/cloud.filters".text = ''
    - .DS_Store
    + /vaults/**
    - **
  '';

  # Use in conjunction with `op-run rclone <args>` to run rclone with 1Password environment variables
  programs.zsh.shellAliases = {
    cloud-pull-destructively = ''rclone sync cloud: ~/cloud --filter-from ~/.config/rclone/cloud.filters --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
    cloud-push = ''rclone sync ~/cloud cloud: --filter-from ~/.config/rclone/cloud.filters --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
    keystone-sync = ''rclone sync cloud: keystone:/cloud --transfers 16 --order-by="size,mixed,75" --create-empty-src-dirs -vP --max-delete 1000 --dry-run'';
  };
}
