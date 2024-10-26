{ pkgs, ... }: {
  xdg.configFile."lf/icons".source = ./icons;
  programs.lf = {
    enable = true;
    settings = {
      icons = true;
      shellopts = "-eu";
      ifs = "\\n";
      scrolloff = 10;
    };
    extraConfig =
      let
        previewer = pkgs.writeShellScriptBin "pv.sh"
          ''
            w=$2
            h=$3
            x=$4
            y=$5
            MIME=$(${pkgs.file}/bin/file -b --mime-type "$1")
            case "$MIME" in
            image/*) ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$1" < /dev/null > /dev/tty
            ;;
            *) ${pkgs.pistol}/bin/pistol "$1";;
            esac
          '';
        cleaner = pkgs.writeShellScriptBin "cleaner.sh"
          ''
            exec ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
          '';
      in
      ''
        set previewer  ${previewer}/bin/pv.sh
        set cleaner  ${cleaner}/bin/cleaner.sh
        map . set hidden!
      '';
  };
}
