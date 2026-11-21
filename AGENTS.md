# AGENTS.md

Guidance for coding agents working in this repository.

nix-nvim is a reusable Neovim distribution built with nixvim: a package and a
`programs.nix-nvim` home-manager module. Language support is opt-in through
`dev.<lang>.enable`.

## Language support and toolchains

nix-nvim makes a language work in the editor; its consumer decides how a
project gets its toolchain. The consumer here is nix-config, which gives each
project its toolchain through a per-project stack (`use_stack` in the project's
`.envrc`) or the project's own dev shell.

| Concern | Owner |
| --- | --- |
| LSP server, formatters, linters, debug adapter, keymaps for a language | nix-nvim, in `nvim/plugins/languages/<lang>.nix` |
| What those tools need to run (cargo for rust-analyzer, go for gopls and gofmt), so a language works with nothing else installed | nix-nvim |
| Which compiler, runtime and build tool versions a project uses | the consumer: a stack or the project's dev shell |
| Whether a project's tool wins over nvim's bundled one on nvim's `PATH` | the consumer, through `programs.nix-nvim.extraConfig` (`dependencies.<name>.packageFallback`, `plugins.lsp.servers.<name>.packageFallback`, `extraPackagesAfter`) |

- Keep nixvim's defaults for `PATH` order. Bundled tools go on nvim's own
  `PATH`, never the user's.
- No code or user docs name a consumer's mechanism: no stacks, direnv, dev
  shells, hosts or users.
- A new language: `nvim/plugins/languages/<lang>.nix` gated on
  `config.dev.<lang>.enable`; declare the option in `nvim/default.nix`
  and `modules/home-manager/default.nix`, and add a row to the README's options
  table.
