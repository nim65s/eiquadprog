{
  description = "Bindings between Numpy and Eigen using Boost.Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    jrl-cmakemodules = {
      url = "github:nim65s/jrl-cmakemodules/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      jrl-cmakemodules,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        eiquadprog = pkgs.callPackage ./default.nix {
          jrl-cmakemodules = jrl-cmakemodules.packages.${system}.default;
        };
      in
      {
        packages.default = eiquadprog;
        devShells.default = pkgs.mkShell { inputsFrom = [ eiquadprog ]; };
      }
    );
}
