{
  description = "A configurable, batteries-included Neovim distribution built with nixvim.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, nixvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        {
          packages.default = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = ./nvim;
          };

          formatter = pkgs.nixfmt-tree;

          # No `checks` that build the package: `nix flake check --all-systems`
          # would then try to realise every system's derivation on one runner
          # (e.g. building the aarch64-darwin package on an x86_64-linux CI box),
          # which fails with a platform mismatch. Actual builds are covered by
          # the dedicated `build` CI job and `nix build`/`nix run`.
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nix
              just
              git
              statix
              deadnix
              nixfmt-tree
            ];
          };
        };

      flake.homeManagerModules.default = import ./modules/home-manager {
        inherit (inputs) nixvim;
      };
    };
}
