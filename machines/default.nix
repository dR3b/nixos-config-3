{ hostSystems ? [ "x86_64-linux" "armv7l-linux" ], ... }:
with import <nixpkgs/lib>;
let
  # Evaluate the configuration for a machine
  callMachine = path: system: import <nixpkgs/nixos/lib/eval-config.nix> {
    modules = [ {  _module.args = { inherit system; }; } path ];
    inherit system;
  };
  realSystem = n: if n.crossSystem != null then n.crossSystem.system else n.localSystem.system;
# Filter out machines with systems that are not supported
in filterAttrs (m: c: builtins.elem (realSystem c.config.nixpkgs) hostSystems) {
  "HP-Z420" = callMachine ./HP-Z420/configuration.nix "x86_64-linux";
  "Dell-Optiplex-780" = callMachine ./Dell-Optiplex-780/configuration.nix "x86_64-linux";
  "ODROID-XU4" = callMachine ./ODROID-XU4/configuration.nix "armv7l-linux";
  "RasPi2" = callMachine ./RasPi2/configuration.nix "armv7l-linux";
  "Rock64" = callMachine ./Rock64/configuration.nix "aarch64-linux";
  "KittyCop" = callMachine ./KittyCop/configuration.nix "armv6l-linux";
}
