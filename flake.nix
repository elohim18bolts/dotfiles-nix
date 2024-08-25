{
  description = "Manage My Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@ { self, nixpkgs,home-manager,... }: 
  let 
    systems = nixpkgs.lib.systems.flakeExposed;
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {pkgs = import nixpkgs { inherit system; };inherit system;});
  in
  {
    defaultPackage = forAllSystems ({pkgs, system}: home-manager.defaultPackage."${system}");
    packages = forAllSystems ({pkgs,system}: {
      homeConfigurations ={
        "darwin" = home-manager.lib.homeManagerConfiguration {
                  # Note: I am sure this could be done better with flake-utils or something
                  inherit pkgs;
                  modules = [ ./systems/macos.nix ./home.nix ]; # Defined later
              };

        "linux" = home-manager.lib.homeManagerConfiguration {
                  # Note: I am sure this could be done better with flake-utils or something
                  inherit pkgs;
                  modules = [ ./systems/linux.nix ./home.nix ]; # Defined later
              };
            };
    });
    formatter = nixpkgs.lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);


  };
}
