{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    formatter =
      builtins.mapAttrs (
        system: pkgs:
          pkgs.alejandra
      )
      nixpkgs.legacyPackages;

    packages =
      builtins.mapAttrs (
        system: pkgs: {
          default = pkgs.callPackage ./package.nix {};
        }
      )
      nixpkgs.legacyPackages;
    nixosModules.default = {pkgs, ...}: {environment.systemPackages = [self.packages."${pkgs.system}".default];};
  };
}
