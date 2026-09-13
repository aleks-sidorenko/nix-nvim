# Overlays applied to the pkgs the distro is built against — in both the flake
# package (CI / `nix build`) and the home-manager module (consumers), so both
# stay in sync.
[
  (_final: prev: {
    # nixpkgs 26.05 pins copilot.lua at refs/tags/v2.0.4 with a stale hash
    # (upstream re-tagged the release), so the fetch fails with a hash mismatch.
    # Refetch the current tag content until nixpkgs refreshes its pin. Extending
    # the vimPlugins scope also fixes dependents (copilot-cmp, copilot-lsp).
    vimPlugins = prev.vimPlugins.extend (
      _pluginsFinal: pluginsPrev: {
        copilot-lua = pluginsPrev.copilot-lua.overrideAttrs (old: {
          src = old.src.overrideAttrs (_: {
            outputHash = "sha256-05f76OeWBlFmlUh90tH4XMMKfNI1jnhuIJDqYPPQokA=";
          });
        });
      }
    );
  })
]
