{ inputs, pkgs, ... }:

{
  home.packages = [

    # Languages & Language Servers
    pkgs.pnpm
    pkgs.nodejs
    pkgs.deno
  ];
}
