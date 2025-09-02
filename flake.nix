{
  description = "Node.js environment";

  # == usage ==
  # 1. use the dev shell by:
  #      nix develop
  # 2. edit node-pkgs/package.json to specify the package name and version by:
  #      npm install -D <package-name>@<version> --package-lock-only
  #      npm uninstall -D <package-name> --package-lock-only
  # 3. re-enter the dev shell by:
  #      exit
  #      nix develop

  # == NOTE ==
  # using nodejs_24, if you need other version, change nodejs
  # node_modules is generated based on package-lock.json
  # you MUST use npm `--package-lock-only` option
  # to ensure the lockfile is updated correctly

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
        # Node.js version
        nodejs = pkgs.nodejs_24;
        # package.json / package-lock location 
        npmRoot = ./.;
        
        inherit (pkgs) importNpmLock;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            nodejs
            importNpmLock.hooks.linkNodeModulesHook
            go-task

            # add pkgs you want to include
            # see below
            pkgs.openssl
            pkgs.python311
          ];

          npmDeps = importNpmLock.buildNodeModules {
            inherit npmRoot nodejs;
          };
        };
      }
    );
}
