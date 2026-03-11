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
      utils = import ./mkHome.nix { inherit nixpkgs home-manager inputs; };
    in
    with utils;
    {
      homeConfigurations = {
        default = self.homeConfigurations."elohim@mbp16";
        "elohim@mbp16" = mkHome "aarch64-darwin" [ ./systems/macos.nix ];
        "elohim@linux64" = mkHome "x86_64-linux" [ ./systems/linux.nix ];

      };
      formatter = nixpkgs.lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
