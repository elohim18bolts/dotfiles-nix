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
            text/*) ${pkgs.bat}/bin/bat --paging=never --color=always --line-range 1:30 "$1";;
            image/*) ${pkgs.viu}/bin/viu -w "$2" -h "$3" $1; tput sc;;
            *) ${pkgs.pistol}/bin/pistol "$1";;
            esac
          '';
        cleaner = pkgs.writeShellScriptBin "cleaner.sh" ''
          tput rc
          #tput ed

        '';

      in
      ''
        set previewer  ${previewer}/bin/pv.sh
        set cleaner ${cleaner}/bin/cleaner.sh
        map . set hidden!
      '';
  };
}
