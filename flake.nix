{
  description = "Node.js environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) importNpmLock;
        nodejs = pkgs.nodejs_24;
        npmRoot = ./.;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            importNpmLock.hooks.linkNodeModulesHook
          ];
          npmDeps = importNpmLock.buildNodeModules {
            inherit npmRoot nodejs;
          };
        };
      }
    );
}
