{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      devshell,
      self,
      ...
    }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        inherit (pkgs)
          ;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };
        texlive-pkgs = with pkgs; texlive.combine { inherit (texlive) scheme-full platex-tools ipaex; };
      in
      rec {
        packages = {
          document =
            pkgs.runCommand "run-latexmk"
              {
                buildInputs = [ texlive-pkgs ];
                src = ./.;
              }
              ''
                cp -r $src/* ./
                cp -r $src/.latexmkrc ./.latexmkrc
                latexmk ./main.tex
                mkdir $out
                cp ./main.pdf $out/main.pdf
              '';
          default = packages.document;
        };
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.devshell.mkShell {
          packages = with pkgs; [
            texlive-pkgs
            nixfmt-rfc-style
          ];
        };
      }
    );
}
