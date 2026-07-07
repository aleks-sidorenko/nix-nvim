# justfile for nix-nvim
# Run `just --list` to see all available recipes

# Default recipe - show help
default:
    @just --list

# Build the neovim package (read-only artifact)
build:
    @echo "🔨 Building nix-nvim package..."
    nix build .#packages.$(nix eval --impure --raw --expr builtins.currentSystem).default

# Launch the built neovim to try it
run:
    @echo "🚀 Launching nix-nvim..."
    nix run .

# Format nix files with nixfmt-tree (writes)
format *path=".":
    @echo "✨ Formatting nix files with nixfmt-tree..."
    nix fmt {{path}}

# Check formatting without modifying files (read-only)
format-check:
    @echo "🔍 Checking nix file formatting..."
    nix fmt -- --ci

# Lint with statix and deadnix (read-only)
lint:
    @echo "🕵️  Checking for issues with statix..."
    statix check .
    @echo "💀 Checking for dead code with deadnix..."
    deadnix --fail .
    @echo "✅ Lint passed!"

# Auto-fix lint issues (statix fix + deadnix --edit)
lint-fix:
    @echo "🔧 Auto-fixing statix issues..."
    statix fix .
    @echo "💀 Removing dead code..."
    deadnix --edit .
    @echo "✅ Lint fixes applied!"

# Read-only quality umbrella: format-check + lint (CI-safe)
check: format-check lint
    @echo "✅ All quality checks passed!"

# Check flake for issues (all declared systems)
flake-check:
    @echo "🔍 Checking flake configuration..."
    nix flake check --all-systems

# Update flake inputs (optionally a single input)
update *input:
    @echo "📦 Updating flake inputs..."
    nix flake update {{ input }}

# Show flake outputs
outputs:
    @echo "📤 Flake outputs:"
    nix flake show
