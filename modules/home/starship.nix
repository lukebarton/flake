{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = false; # Using evalcache for faster init

    settings = {
      add_newline = true;
      format = "$hostname$directory$git_branch$git_commit$git_state$git_metrics$git_status$kubernetes$direnv$docker_context$package$golang$nodejs$python$rust$terraform$nix_shell$env_var$cmd_duration$fill$time$line_break$jobs$status$character";

      hostname = {
        ssh_only = true;
        style = "";
        ssh_symbol = "";
      };

      fill.symbol = " ";

      character = {
        success_symbol = "[%](default)";
        vicmd_symbol = "[%](default)";
        error_symbol = "[%](bold red)";
      };

      git_branch = {
        style = "fg:dark_grey";
        symbol = " ";
      };

      git_status.style = "fg:dark_grey";
      git_state.style = "fg:dark_grey";
      git_metrics.added_style = "fg:dark_grey";

      directory = {
        style = "fg:dark_grey";
        truncation_symbol = "../";
      };

      jobs = {
        symbol = "·";
        style = "bold red";
      };

      time = {
        disabled = false;
        style = "";
        format = "[$time]($style) ";
      };

      nix_shell = {
        disabled = false;
        style = "";
        format = "via [󱄅 $state( ($name))](bold blue) ";
      };

      terraform.disabled = true;
      package.disabled = true;

      golang = {
        disabled = false;
        style = "";
        format = "via [󰟓 ($version )]($style)";
      };

      kubernetes = {
        style = "";
        format = "[󱃾 $context( in $namespace)]($style) ";
        disabled = false;
      };

      python = {
        disabled = false;
        format = "via [ ($version )]($style)(($virtualenv))";
        style = "fg:dark_grey";
        detect_extensions = [ ];
        detect_files = [
          ".python-version"
          "Pipfile"
          "__init__.py"
          "pyproject.toml"
          "requirements.txt"
          "setup.py"
          "tox.ini"
        ];
      };

      nodejs = {
        disabled = false;
        style = "fg:dark_grey";
        format = "via [⬢ ($version )]($style)";
      };

      rust = {
        disabled = false;
        style = "fg:dark_grey";
        format = "via [🦀 ($version )]($style)";
      };

      docker_context = {
        disabled = true;
        style = "";
      };

      direnv.disabled = false;
    };
  };
}
