{pkgs,...}: 
let
    ls-colors = (pkgs.runCommand "ls-coreutils" {} ''
    mkdir -p "$out/bin"
    mkdir -p "$out/share/ls_colors"
    ln -s ${pkgs.coreutils}/bin/ls "$out/bin/ls"
    cp ${./ls_colors} "$out/share/ls_colors/LS_COLORS"
    '');
in{
  home.packages = [
    ls-colors
  ];


  home.sessionVariables = {
    # EDITOR = "emacs";
    LS_COLORS = (builtins.readFile "${./ls_colors}");
  };


}
