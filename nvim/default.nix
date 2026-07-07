{
  lib,
  ...
}:
{
  # Public configuration options for this nixvim module.
  options = {
    development = {
      haskell.enable = lib.mkEnableOption "Haskell development support";
      rust.enable = lib.mkEnableOption "Rust development support";
      python.enable = lib.mkEnableOption "Python development support";
      go.enable = lib.mkEnableOption "Go development support";
      typescript.enable = lib.mkEnableOption "TypeScript development support";
      scala.enable = lib.mkEnableOption "Scala development support";
      java.enable = lib.mkEnableOption "Java development support";
    };
    ai = {
      copilot.enable = lib.mkEnableOption "GitHub Copilot AI assistant";
      claude-code.enable = lib.mkEnableOption "Claude Code AI assistant";
    };
    theme = lib.mkOption {
      type = lib.types.enum [ "catppuccin" ];
      default = "catppuccin";
      description = "Colorscheme to use.";
    };
  };

  config = {
    development = {
      haskell.enable = lib.mkDefault false;
      rust.enable = lib.mkDefault false;
      python.enable = lib.mkDefault false;
      go.enable = lib.mkDefault false;
      typescript.enable = lib.mkDefault false;
      scala.enable = lib.mkDefault false;
      java.enable = lib.mkDefault false;
    };
    ai = {
      copilot.enable = lib.mkDefault false;
      claude-code.enable = lib.mkDefault false;
    };
  };

  # Top-level reserved key — NOT under config.
  imports = import ../lib/import-tree.nix lib ./.;
}
