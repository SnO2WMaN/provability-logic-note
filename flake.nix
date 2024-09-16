{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
    texshell.url = "github:jorsn/texshell.nix";
  };

  outputs =
    {
      nixpkgs,
      texshell,
      flake-utils,
      devshell,
      self,
      ...
    }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        inherit (pkgs) ;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.devshell.mkShell {
          packages = with pkgs; [
            (texlive.combine {
              inherit (texlive) scheme-full platex-tools ipaex;
            })
          ];
        };
      }
    );
}
