{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-24.11;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            # allowUnfree = true;
          };
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.just
            pkgs.go
          ];

          shellHook = ''
            export GOPATH="$PWD/.go"
            export PATH="$PATH:$GOPATH/bin"
          '';
        };
      });
}
