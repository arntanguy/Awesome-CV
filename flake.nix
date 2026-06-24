{
  description = "LaTeX Document Demo";

  inputs = {
    # Using a more recent nixpkgs is recommended for better LuaLaTeX support
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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
        mkDocument = {folder, latexFileName}: 
          pkgs.stdenvNoCC.mkDerivation {
          pname = "${latexFileName}";
          version = "1.0.0";
          src = ./.;
          buildInputs = [ pkgs.coreutils tex pkgs.biber ];
          # needs a writable place to initialize font caches.
          buildPhase = ''
            set -e
            export HOME=$(mktemp -d)
            mkdir -p .cache/texmf-var

            export TEXINPUTS="`pwd`/pkgs:"
            export TEXMFHOME=.cache
            export TEXMFVAR=.cache/texmf-var

            cd ${folder}
            xelatex -interaction=nonstopmode ${latexFileName}.tex || true
            biber ${latexFileName} || true
            xelatex -interaction=nonstopmode ${latexFileName}.tex || true
          '';

          installPhase = ''
            mkdir -p $out/${folder}
            cp ${latexFileName}.pdf $out/${folder}/${latexFileName}.pdf
          '';
        };
        docs = {
          french_cv_detailed = mkDocument { folder = "cv_arnaud_french"; latexFileName = "cv_arnaud_french_detailed"; };
          french_cv_short = mkDocument { folder = "cv_arnaud_french"; latexFileName = "cv_arnaud_french_short"; };
          french_motivation_lirmm_2026 = mkDocument { folder = "cv_arnaud_french"; latexFileName = "coverletter_lirmm_2026"; };
          french_coverletter_cnrs_2020 = mkDocument { folder = "cv_arnaud_french"; latexFileName = "coverletter_cnrs_concours_2020"; };
          english_cv_outdated = mkDocument { folder = "cv_arnaud_english"; latexFileName = "cv_arnaud_english"; };
        };
      in
      {
          # Merge the documents into your final packages output
          packages = docs // {
            # Collect all values from the 'docs' set automatically
            all_documents = pkgs.symlinkJoin {
              name = "all-documents"; # symlinkJoin usually expects a name attribute
              paths = builtins.attrValues docs;
            };
          };

        defaultPackage = self.packages.${system}.all_documents;

        # Optional: Add a devShell so you can run 'nix develop' to test locally
        devShells.default = pkgs.mkShell {
          buildInputs = [ tex ];
        };
      });
}
