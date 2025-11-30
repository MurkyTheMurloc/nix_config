{ inputs, pkgs, ... }:

{
  home.packages = [

    # Languages & Language Servers
    pkgs.astro-language-server
    pkgs.biome
    pkgs.cargo
    pkgs.dprint
    pkgs.emmet-language-server
    pkgs.gleam
    pkgs.go
    pkgs.gopls
    pkgs.just
    pkgs.lua-language-server
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.openssl
    pkgs.python312
    pkgs.ruff
    pkgs.stylua
    pkgs.taplo
    pkgs.vscode-langservers-extracted
    pkgs.vtsls
    pkgs.eslint_d
    pkgs.zoxide
	#    pkgs.tailwind
	#pkgs.graphql-lsp
    pkgs.rust-analyzer
    pkgs.rustc
    pkgs.rustfmt
    pkgs.marksman # Markdown
    pkgs.zls # Zig
    pkgs.yaml-language-server
    pkgs.bash-language-server
	#pkgs.kubernetes-language-server
	#pkgs.sql-language-server
	#pkgs.dockerfile-language-server
  ];
}
