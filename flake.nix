{
  description = "Manage My Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systems = nixpkgs.lib.systems.flakeExposed;
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f { pkgs = import nixpkgs { inherit system; };inherit system; });
      lib = nixpkgs.lib;
    in
    {
      packages = forAllSystems
        ({ pkgs, system }: {
          homeConfigurations = {
            "elohim" = home-manager.lib.homeManagerConfiguration {
              # Note: I am sure this could be done better with flake-utils or something
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
              modules = [ ./home.nix ]
                ++ lib.optionals (pkgs.stdenv.isDarwin) [ ./systems/macos.nix ]
                ++ lib.optionals (pkgs.stdenv.isLinux) [ ./systems/linux.nix ]; # Defined later
            };
          };
        });
      formatter = nixpkgs.lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
