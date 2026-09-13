{ pkgs, ... }:
{
  plugins.copilot-cmp.enable = true;

  plugins.copilot-lua = {
    enable = true;

    # nixpkgs 26.05 pins copilot.lua at refs/tags/v2.0.4 with a stale hash
    # (upstream re-tagged the release), so the fetch fails with a hash mismatch.
    # Refetch the current tag content until nixpkgs refreshes its pin.
    package = pkgs.vimPlugins.copilot-lua.overrideAttrs (old: {
      src = old.src.overrideAttrs (_: {
        outputHash = "sha256-05f76OeWBlFmlUh90tH4XMMKfNI1jnhuIJDqYPPQokA=";
      });
    });

    settings = {
      suggestion.enabled = false;
      panel.enabled = false;

      filetypes = {
        yaml = false;
        markdown = false;
        json = false;
        help = false;
        gitcommit = false;
        gitrebase = false;
      };
    };
  };
}
