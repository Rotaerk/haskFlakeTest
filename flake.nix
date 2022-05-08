{
  description = "A haskell test flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    hs = pkgs.haskellPackages;
    haskFlakeTest = hs.callCabal2nix "haskFlakeTest" ./. {};
  in {

    packages.x86_64-linux = { inherit haskFlakeTest; };

    devShells.x86_64-linux.default = hs.shellFor {
      packages = p: [ haskFlakeTest ];
      nativeBuildInputs = with hs; [
        cabal-install
        haskell-language-server
      ];
    };

  };
}
