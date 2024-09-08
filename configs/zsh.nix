{ lib, pkgs, stdenv, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 5000;
      save = 30000;
    };
    autocd = true;
    defaultKeymap = "viins";
    initExtra = ''
    '' + lib.optionalString stdenv.isDarwin ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
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
    };
  };

  programs.fzf = {
    enable = true;
  };
  programs.starship = {
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

