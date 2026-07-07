{ nixvim }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nix-nvim;

  basePackage = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs; # consumer's pkgs — honours their overlays/pins
    module = ../../nvim; # bare path (same form as flake.nix's ./nvim)
  };
in
{
  options.programs.nix-nvim = {
    enable = lib.mkEnableOption "nix-nvim Neovim distribution";

    development = {
      haskell.enable = lib.mkEnableOption "Haskell support";
      rust.enable = lib.mkEnableOption "Rust support";
      python.enable = lib.mkEnableOption "Python support";
      go.enable = lib.mkEnableOption "Go support";
      typescript.enable = lib.mkEnableOption "TypeScript support";
      scala.enable = lib.mkEnableOption "Scala support";
      java.enable = lib.mkEnableOption "Java support";
    };

    ai = {
      copilot.enable = lib.mkEnableOption "GitHub Copilot";
      claude-code.enable = lib.mkEnableOption "Claude Code";
    };

    theme = lib.mkOption {
      type = lib.types.enum [ "catppuccin" ];
      default = "catppuccin";
      description = "Colorscheme to use.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = basePackage;
      defaultText = lib.literalMD "nix-nvim built against the consumer's `pkgs`";
      description = "The base nix-nvim package to extend.";
    };

    extraConfig = lib.mkOption {
      type = with lib.types; either attrs (listOf attrs);
      default = { };
      description = "Extra nixvim module(s) merged via .extend (a module or list of modules).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (cfg.package.extend (
        [
          {
            config = {
              development = {
                haskell.enable = lib.mkIf cfg.development.haskell.enable (lib.mkForce true);
                rust.enable = lib.mkIf cfg.development.rust.enable (lib.mkForce true);
                python.enable = lib.mkIf cfg.development.python.enable (lib.mkForce true);
                go.enable = lib.mkIf cfg.development.go.enable (lib.mkForce true);
                typescript.enable = lib.mkIf cfg.development.typescript.enable (lib.mkForce true);
                scala.enable = lib.mkIf cfg.development.scala.enable (lib.mkForce true);
                java.enable = lib.mkIf cfg.development.java.enable (lib.mkForce true);
              };
              ai = {
                copilot.enable = lib.mkIf cfg.ai.copilot.enable (lib.mkForce true);
                claude-code.enable = lib.mkIf cfg.ai.claude-code.enable (lib.mkForce true);
              };
              theme = cfg.theme;
            };
          }
        ]
        ++ lib.toList cfg.extraConfig
      ))
    ];
  };
}
