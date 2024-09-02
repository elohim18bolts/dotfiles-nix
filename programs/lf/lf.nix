{ pkgs, lib, ... }: {
  programs.lf = {
    enabled = true;
    extraConfig =
      let
        previewer = writeShellScriptBin "pv.sh" ''
          MIME=''$(${pkgs.file}/bin/file -b --mime-type "''$1")
          case "MIME" in
          *) ${pkgs.pistol}/bin/pistol "''$1";;
          esac
        '';
      in
      ''
        previewer = ${previewer}/bin/pv.sh
      '';
  };
}
