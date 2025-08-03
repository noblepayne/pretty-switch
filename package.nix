{
  writeShellApplication,
  nixos-rebuild,
  nix-output-monitor,
  ...
}:
writeShellApplication {
  name = "pretty-switch";
  runtimeInputs = [nixos-rebuild nix-output-monitor];
  text = ''
    nom build "$(dirname "$(realpath /etc/nixos/flake.nix)")/#nixosConfigurations.$(hostname).config.system.build.toplevel"
    nixos-rebuild "''${1:-switch}"
  '';
}
