# nix-nvim

[![CI](https://github.com/aleks-sidorenko/nix-nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/aleks-sidorenko/nix-nvim/actions/workflows/ci.yml)

A configurable, batteries-included Neovim distribution built with [nixvim](https://github.com/nix-community/nixvim). It ships sane defaults for editing, LSP, and UI out of the box, and exposes opt-in toggles for language support and AI assistants — usable as a standalone package or as a `programs.nix-nvim` home-manager module.

## Try it

```sh
nix run github:aleks-sidorenko/nix-nvim
```

## Home-manager usage

Add the flake input and follow `nixpkgs` for a reproducible build that uses identical package versions to your existing system:

```nix
# flake.nix inputs
nix-nvim = {
  url = "github:aleks-sidorenko/nix-nvim";
  inputs.nixpkgs.follows = "nixpkgs";
};

# home-manager module
{
  imports = [ inputs.nix-nvim.homeManagerModules.default ];
  programs.nix-nvim = {
    enable = true;
    development = { rust.enable = true; go.enable = true; };
    ai.claude-code.enable = true;
    theme = "catppuccin";
  };
}
```

### Available options

| Option | Type | Description |
|--------|------|-------------|
| `development.haskell.enable` | bool | Haskell LSP + tooling |
| `development.rust.enable` | bool | Rust LSP + tooling |
| `development.python.enable` | bool | Python LSP + tooling |
| `development.go.enable` | bool | Go LSP + tooling |
| `development.typescript.enable` | bool | TypeScript LSP + tooling |
| `development.scala.enable` | bool | Scala LSP + tooling |
| `development.java.enable` | bool | Java LSP + tooling |
| `ai.copilot.enable` | bool | GitHub Copilot AI assistant |
| `ai.claude-code.enable` | bool | Claude Code AI assistant |
| `theme` | enum | Colorscheme — currently `"catppuccin"` |

## Advanced

`extraConfig` accepts a nixvim module or a list of modules, merged via `.extend`. Use it to override or extend anything in the base config:

```nix
programs.nix-nvim = {
  enable = true;
  extraConfig = {
    plugins.telescope.enable = false;
  };
};
```

## Real-world example

For a complete production setup, see [`aleks-sidorenko/nix-config`](https://github.com/aleks-sidorenko/nix-config) — it consumes this flake across NixOS, nix-darwin, and home-manager systems. The integration is a thin home-manager wrapper that maps its own role/option system onto `programs.nix-nvim` and layers [stylix](https://github.com/nix-community/stylix) theming on top:

- Flake input: [`flake.nix`](https://github.com/aleks-sidorenko/nix-config/blob/master/flake.nix) (`nix-nvim` with `inputs.nixpkgs.follows = "nixpkgs"`)
- Wrapper module: [`modules/home/cli/editors/nvim/default.nix`](https://github.com/aleks-sidorenko/nix-config/blob/master/modules/home/cli/editors/nvim/default.nix)

## Reproducibility note

Consumers should always set `inputs.nixpkgs.follows = "nixpkgs"` so that nix-nvim builds against the same `nixpkgs` revision as the rest of the system. Without this, nix-nvim pins its own `nixpkgs`, which increases closure size and may produce a Neovim built against different system libraries.

## License

MIT — see [LICENSE](./LICENSE).
