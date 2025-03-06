{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#4f5b00";
    };
    syntaxHighlighting.enable = true;
    history = {
      size = 5000;
      save = 30000;
    };
    autocd = true;
    defaultKeymap = "viins";
    initExtra = '' bindkey -e 'jk' vi-cmd-mode
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
    '' + ''
      if [ -n "$IN_NIX_SHELL" ];then
         export PS1="$PS1:nix-shell > "
      fi
    '';

    plugins = [
      rec{
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/${name}";
      }
    ];

    shellAliases = {
      ls = "ls --color=auto -F";
      grep = "grep --color";
      k = "kubectl";
      gin = "git init";
      gic = "git commit";
      gad = "git add";
      gpo = "git push origin";
      rm = "${pkgs.trash-cli}/bin/trash-put";
    };
  };

  programs.fzf = {
    enable = true;
  };
  programs.keychain = {
    enable = true;
    keys = [ ];
    extraFlags = [ "--quiet" "$\{$(find ~/.ssh -iname '*.pub')%.pub\}" ];
  };
  home.sessionVariables = {
    NVM_DIR = "$([ -z \"$\{XDG_CONFIG_HOME-\}\" ] && printf %s \"$\{HOME\}/.nvm\" || printf %s \"/usr/share/nvm\")";
    TERM = "xterm";
    EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

}

