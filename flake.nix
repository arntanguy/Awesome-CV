{
  description = "LaTeX Document Demo";

  inputs = {
    # Using a more recent nixpkgs is recommended for better LuaLaTeX support
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Combine TeX packages: basic scheme includes fonts and core tools
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) 
            scheme-basic
            latexmk
            luaotfload
            latex-bin
            ragged2e
            babel
            babel-french
            biblatex
            geometry
            fontspec
            xetex
            xecjk
            xunicode
            xstring
            xcolor
            enumitem
            xifthen
            ifmtarg
            setspace
            tcolorbox
            sourcesanspro
            unicode-math
            environ
            tikzfill
            parskip
            csquotes
          ;
        };
      in
      {
        packages.document = pkgs.stdenvNoCC.mkDerivation rec {
          pname = "latex-demo-document";
          version = "1.0.1";
          src = ./.;
          buildInputs = [ pkgs.coreutils tex pkgs.biber ];
          # needs a writable place to initialize font caches.
          buildPhase = ''
                set -e
                export HOME=$(mktemp -d)
                mkdir -p .cache/texmf-var

                cd cv_arnaud_french
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                  xelatex -interaction=nonstopmode cv_arnaud_french.tex || true
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                  biber cv_arnaud_french || true
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                  xelatex -interaction=nonstopmode cv_arnaud_french.tex || true

                ls -al

                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                xelatex -interaction=nonstopmode coverletter_lirmm_2026.tex || true
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                  biber coverletter_lirmm_2026 || true
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                xelatex -interaction=nonstopmode coverletter_lirmm_2026.tex || true
          '';

          installPhase = ''
            mkdir -p $out
            cp cv_arnaud_french.pdf $out/
            cp coverletter_lirmm_2026.pdf $out/
          '';
        };

        defaultPackage = self.packages.${system}.document;

        # Optional: Add a devShell so you can run 'nix develop' to test locally
        devShells.default = pkgs.mkShell {
          buildInputs = [ tex ];
        };
      });
}
