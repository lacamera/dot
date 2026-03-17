{
  description = "macOS-first dotfiles with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, ... }:
    let
      user = "fm";
      system = "aarch64-darwin";
      host = "macbook";
    in {
      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs self user;
        };
        modules = [
          ./hosts/macbook
          home-manager.darwinModules.home-manager
          {
            users.users.${user}.home = "/Users/${user}";

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs self user;
            };
            home-manager.users.${user} = import ./hosts/macbook/home.nix;
          }
        ];
      };
    };
}
