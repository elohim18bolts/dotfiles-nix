
{ config, pkgs, lib,... }: 
{

  nixpkgs.config = {
    allowUnfree = true;
    # allowUnfreePredicate = (_: true);
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "terraform"
    ];
  };
  programs.emacs = {
    enable = false;
    extraPackages = epkgs: with epkgs; [go-guru nix-mode lsp-mode];
  };
  home.packages = if config.programs.emacs.enable == true then [
    (pkgs.ripgrep.override {withPCRE2 = true;})
    pkgs.git
    pkgs.gzip
    pkgs.emacs-all-the-icons-fonts
    pkgs.fd
    pkgs.gopls
    pkgs.nixfmt-rfc-style
    pkgs.direnv
    pkgs.dockfmt
    pkgs.go
    pkgs.gomodifytags
    pkgs.gore
    pkgs.gotests
    pkgs.terraform
    pkgs.rust-analyzer
    pkgs.cargo
    pkgs.rustc
    pkgs.shfmt
    pkgs.stylelint
    pkgs.nodePackages.js-beautify
    pkgs.shellcheck
    pkgs.pandoc
  ] else [];
    
  

  # Note! This must correspond to $EMACSDIR
  xdg.configFile."emacs" = {
    enable = true;
    recursive = true;
    executable = false;
    source = builtins.fetchGit {
    url = "https://github.com/doomemacs/doomemacs.git";
    rev = "f5020a4f7f228a84a51039a57fbf67107a0f2d74";
    };
  };

 
  

  home.sessionVariables = {
    # EDITOR = "emacs";
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR= "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
    DOOMPROFILELOADFILE = "${config.xdg.stateHome}/doom-profiles-load.el";
  };
  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  xdg.configFile."doom" = {
    enable = config.programs.emacs.enable;
    executable = false;
    recursive = true;
    source  = ../configs/doom;
    target = "${config.xdg.configHome}/doom";
  };
  home.activation.doom = lib.hm.dag.entryAfter ["writeBoundary"] ''
  if [ -x "${config.xdg.configHome}/emacs/bin/doom" ]; then
  export PATH=$PATH:"${pkgs.emacs}/bin:${pkgs.git}/bin"
  export DOOMDIR="${config.xdg.configHome}/doom"
  export EMACSDIR="${config.xdg.configHome}/emacs"
  export DOOMLOCALDIR="${config.xdg.dataHome}/doom"
  "${config.xdg.configHome}"/emacs/bin/doom install
  "${config.xdg.configHome}"/emacs/bin/doom sync
  fi
  '';
}
