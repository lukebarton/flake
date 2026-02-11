{ pkgs, ... }: {

  programs.gh = {
    enable = true;
    extensions = [
      # TODO: gh-ssh-allowed-signers
    ];
  };

  home.file.".gitignore".source = ../files/git/.gitignore;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Luke Barton";
        email = "luke@lukebarton.co.uk";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAt8HNjBNhpCKNU9T4nccoXIMAOACjAO56W1YGzLsnr";
      };
      alias = {
        addm = "!git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git add";
        addmp = "!git ls-files --deleted --modified --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r -o git add -p";
        cb = "!git branch --all | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --preview 'git show --color=always {-1}' | sed 's/remotes\\/origin\\///g' | xargs -r git checkout";
        cs = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash pop";
        db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete";
        Db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete --force";
        ds = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash drop";
        edit = "!git ls-files --modified --other --exclude-standard | sort -u | fzf -0 --multi --preview 'git diff --color {}' | xargs -r $EDITOR -p";
        fixup = "!git log --oneline --no-decorate --no-merges | fzf -0 --preview 'git show --color=always --format=oneline {1}' | awk '{print $1}' | xargs -r git commit --fixup";
        resetm = "!git diff --name-only --cached | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git reset";
      };

      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };

      commit = {
        gpgsign = true;
        verbose = true;
      };

      tag = {
        sort = "version:refname";
        gpgsign = true;
      };


      column.ui = "auto";
      branch.sort = "-committerdate";
      init.defaultBranch = "main";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
        tool = "zed";
      };

      difftool."zed".cmd = "zed --wait --diff \"$LOCAL\" \"$REMOTE\"";

      merge = {
        tool = "zed";
        conflictstyle = "zdiff3";
      };

      mergetool."zed" = {
        cmd = "zed --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"";
        trustExitCode = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        prunetags = false;
        all = true;
      };

      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      core = {
        eol = "lf";
        autocrlf = "input";
        excludesfile = "~/.gitignore";
        pager = "diff-so-fancy | less --tabs=4 -R";
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      pull.rebase = true;

      "diff-so-fancy" = {
        markEmptyLines = false;
        stripLeadingSymbols = false;
      };

      "url \"ssh://git@github.com/\"" = {
        insteadOf = [ "https://github.com/" "git://github.com/" ];
      };
    };
  };
}