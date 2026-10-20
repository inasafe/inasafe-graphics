# SPDX-FileCopyrightText: Kartoza
# SPDX-License-Identifier: CC0-1.0
{
  description = "Dev shell for the inasafe-graphics brand-asset repository.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.imagemagick
          pkgs.exiftool
          pkgs.fontconfig
          pkgs.pre-commit
          pkgs.markdownlint-cli
          pkgs.yamllint
          pkgs.reuse
          pkgs.gitleaks
        ];

        shellHook = ''
          if command -v pre-commit >/dev/null && [ -d .git ]; then
            pre-commit install --install-hooks >/dev/null 2>&1 || true
          fi
        '';
      };
    };
}
