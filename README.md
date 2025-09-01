# nodejs_nix_env
A reproducible Node.js (24) development environment powered by Nix Flakes.
Nix generates `node_modules` from your `package-lock.json`, and the template ships with TypeScript and ESLint ready to go.

## Features
- Pin Node.js 24 via Nix (easy to change)
- Reproduce `node_modules` from `package-lock.json` with Nix
- TypeScript + ESLint + [typescript-eslint](https://typescript-eslint.io/)
- Include extra build tooling in the devShell (e.g. `openssl`, `python311`) (easy to change)

## Prerequisites
- Nix installed with Flakes enabled
  - cf. [NixOS wiki](https://wiki.nixos.org/wiki/Flakes)

## Quick Start
1. Enter the development shell
    - `nix develop`
2. Use linter
    - `npm run lint`
3. Build TypeScript
    - `npm run build`
4. Run dist/linter_check.js
    - `node dist/linter_check.js`

## Managing Dependencies (Important)
In this template, Nix generates `node_modules` from `package-lock.json`.
Do not run plain `npm install` to mutate `node_modules` directly.

- Add: `npm install -D <package>@<version> --package-lock-only`
- Remove: `npm uninstall -D <package> --package-lock-only`
- Apply: re-enter the devShell (`exit` → `nix develop`)

Notes:
- All changes are recorded only in `package-lock.json`

## Project Structure
- `src/`: Example code (`src/linter_check.ts`)
- `tsconfig.json`: TypeScript configuration
- `eslint.config.mjs`: ESLint Config using `@eslint/js` and `typescript-eslint`
- `flake.nix`: Nix Flake devShell config (change Node version or bundled tools)

## Change Node Version
Edit `nodejs` in `flake.nix` (e.g. switch to `pkgs.nodejs_20`).

## Bundling Additional Tools
Add any native build dependencies to `devShells.default.packages` in `flake.nix`.
    - cf. [NIx Search](https://search.nixos.org/packages)

## Troubleshooting
- node_modules not updating
  - Ensure `package-lock.json` changed and re-enter the devShell
- Flakes reported as disabled
  - See the enabling instructions under Prerequisites
- Accidentally ran `npm install`
  - If artifacts were created, `rm -rf node_modules` and run `nix develop` again

## Optional: direnv Integration
You can use [direnv](https://direnv.net/) with [nix-direnv](https://github.com/nix-community/nix-direnv) to automatically enter the Nix devShell when changing into the project directory.  
See their documentation for setup instructions.
