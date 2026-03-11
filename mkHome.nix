{ nixpkgs
, home-manager
, ...
}@inputs:
{

  mkHome = system: fileList:
    let pkgs = import nixpkgs { inherit system; }; in
    home-manager.lib.homeManagerConfiguration {
      # Note: I am sure this could be done better with flake-utils or something
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
        inherit system;
      };
      modules = [ ./home.nix ] ++ fileList;
      #++ lib.optionals (pkgs.stdenv.isDarwin) [ ./systems/macos.nix ]
      #++ lib.optionals (pkgs.stdenv.isLinux) [ ./systems/linux.nix ]; # Defined later
    };

}

