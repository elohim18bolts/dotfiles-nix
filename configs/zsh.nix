{config, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
       path =  "~./histfile";
       size = 5000;
       save = 30000;
    };
    autocd = true;
    defaultKeymap = "viins";
    initExtraFirst= ''
zstyle ':completion:*' completer _list _expand _complete _ignored _match _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
    '';

    initExtra = ''
source <(kubectl completion zsh)
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
  programs.keychain =  {
    enable = true;
    keys = [];
    extraFlags = ["--quiet" "$\{$(find ~/.ssh -iname '*.pub')%.pub\}" ];
  };
  home.sessionVariables = {
    NVM_DIR="$([ -z \"$\{XDG_CONFIG_HOME-\}\" ] && printf %s \"$\{HOME\}/.nvm\" || printf %s \"/usr/share/nvm\")";
    TERM = "xterm";
    EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

}

