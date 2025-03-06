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
            *) ${pkgs.pistol}/bin/pistol "$1";;
            esac
          '';
      in
      ''
        set previewer  ${previewer}/bin/pv.sh
        map . set hidden!
      '';
  };
}
