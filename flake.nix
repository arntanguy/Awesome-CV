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
            roboto
            fontawesome
          ;
        };
      in
      {
        packages.document = pkgs.stdenvNoCC.mkDerivation rec {
          pname = "latex-demo-document";
          version = "1.0.5";
          src = ./.;
          buildInputs = [ pkgs.coreutils tex pkgs.biber ];
          # needs a writable place to initialize font caches.
          buildPhase = ''
            set -e
            export HOME=$(mktemp -d)
            mkdir -p .cache/texmf-var

            PKGS="`pwd`/pkgs:"
            echo "pkgs ===="
            echo $PKGS
            export TEXINPUTS=$PKGS
            ls `pwd`
            echo "pkgs ===="

            cd cv_arnaud_french
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode cv_arnaud_french.tex || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              biber cv_arnaud_french || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode cv_arnaud_french.tex || true

            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode coverletter_lirmm_2026.tex || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              biber coverletter_lirmm_2026 || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode coverletter_lirmm_2026.tex || true

            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode coverletter_cnrs.tex || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              biber coverletter_cnrs || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode coverletter_cnrs.tex || true

            cd ../cv_arnaud_english
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode cv_arnaud_english.tex || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              biber cv_arnaud_english || true
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              xelatex -interaction=nonstopmode cv_arnaud_english.tex || true

            cd ..
          '';

          installPhase = ''
            mkdir -p $out/french
            mkdir -p $out/english
            cp cv_arnaud_french/cv_arnaud_french.pdf $out/french/CV_Arnaud_Tanguy_French.pdf
            cp cv_arnaud_french/coverletter_lirmm_2026.pdf $out/french/
            cp cv_arnaud_french/coverletter_cnrs.pdf $out/french/
            cp cv_arnaud_english/cv_arnaud_english.pdf $out/english/CV_Arnaud_Tanguy_English.pdf
          '';
        };

        defaultPackage = self.packages.${system}.document;

        # Optional: Add a devShell so you can run 'nix develop' to test locally
        devShells.default = pkgs.mkShell {
          buildInputs = [ tex ];
        };
      });
}
