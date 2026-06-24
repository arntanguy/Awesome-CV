{
  description = "LaTeX Document Demo";

  inputs = {
    # FIXME upgrading breaks awesome-cv formatting
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    tex-fmt.url = "github:wgunderwood/tex-fmt";
    # tex-fmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, treefmt-nix, tex-fmt, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Evaluate treefmt for this system
        treefmtEval = treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          settings.global.excludes = [
            ".envrc"
            ".git-blame-ignore-revs"
            ".jrl-ci"
            "3rd-party/*"
            "doc/*"
            "LICENSE"
          ];
          # Use the package straight from the tex-fmt input flake!
          settings.formatter.tex-fmt = {
            command = "${tex-fmt.packages.${system}.default}/bin/tex-fmt";
            includes = [ "*.tex" "*.bib" ];
            # Add your custom formatting arguments here
            # Correct options for tex-fmt
            options = [ "--tabsize" "2" "--wraplen" "120" ];
          };
          programs = {
            mdformat.enable = true;
            nixfmt.enable = true;
          };
        };

        # Combine TeX packages
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic latexmk luaotfload latex-bin ragged2e babel
            babel-french biblatex geometry fontspec xetex xecjk xunicode xstring
            xcolor enumitem xifthen ifmtarg setspace tcolorbox sourcesanspro
            unicode-math environ tikzfill parskip csquotes roboto fontawesome;
        };

        compile-doc = pkgs.writeShellScriptBin "compile-doc" ''
          if [ -z "$1" ] || [ -z "$2" ]; then
            echo "Usage: compile-doc <folder> <latexFileName>"
            echo "Example: compile-doc cv_arnaud_french cv_arnaud_french_detailed"
            exit 1
          fi

          FOLDER="$1"
          FILE_NAME="$2"
          BUILD_DIR="build"

          export HOME=$(mktemp -d)
          mkdir -p .cache/texmf-var

          export TEXINPUTS="$(pwd)/pkgs:"
          export TEXMFHOME=.cache
          export TEXMFVAR=.cache/texmf-var

          # 1. Jump into the target folder and create the build directory
          cd "$FOLDER"
          mkdir -p "$BUILD_DIR"

          # 2. Compile Pass 1 (directing outputs to the build folder)
          echo "--- Running xelatex (Pass 1) ---"
          ${tex}/bin/xelatex -interaction=nonstopmode -output-directory="$BUILD_DIR" "$FILE_NAME".tex || true

          # 3. Process bibliography (biber needs to find files inside the build directory)
          echo "--- Running biber ---"
          ${pkgs.biber}/bin/biber --output-directory="$BUILD_DIR" "$BUILD_DIR/$FILE_NAME" || true

          # 4. Compile Pass 2
          echo "--- Running xelatex (Pass 2) ---"
          ${tex}/bin/xelatex -interaction=nonstopmode -output-directory="$BUILD_DIR" "$FILE_NAME".tex || true

          echo "Done! Generated $FOLDER/$BUILD_DIR/$FILE_NAME.pdf"
        '';

        mkDocument = { folder, latexFileName, }:
          pkgs.stdenvNoCC.mkDerivation {
            pname = latexFileName;
            version = "1.0.0";
            src = ./.;
            buildInputs = [ pkgs.coreutils tex pkgs.biber ];

            buildPhase = ''
              ${compile-doc}/bin/compile-doc "${folder}" "${latexFileName}"
            '';
            #   ''
            #   set -e
            #   export HOME=$(mktemp -d)
            #   mkdir -p .cache/texmf-var
            #
            #   export TEXINPUTS="`pwd`/pkgs:"
            #   export TEXMFHOME=.cache
            #   export TEXMFVAR=.cache/texmf-var
            #
            #   cd ${folder}
            #   xelatex -interaction=nonstopmode ${latexFileName}.tex || true
            #   biber ${latexFileName} || true
            #   xelatex -interaction=nonstopmode ${latexFileName}.tex || true
            # '';

            installPhase = ''
              mkdir -p $out/${folder}
              cp ${folder}/build/${latexFileName}.pdf $out/${folder}/${latexFileName}.pdf
            '';
          };

        docs = {
          french_cv_detailed = mkDocument {
            folder = "cv_arnaud_french";
            latexFileName = "cv_arnaud_french_detailed";
          };
          french_cv_short = mkDocument {
            folder = "cv_arnaud_french";
            latexFileName = "cv_arnaud_french_short";
          };
          french_motivation_lirmm_2026 = mkDocument {
            folder = "cv_arnaud_french";
            latexFileName = "coverletter_lirmm_2026";
          };
          french_coverletter_cnrs_2020 = mkDocument {
            folder = "cv_arnaud_french";
            latexFileName = "coverletter_cnrs_concours_2020";
          };
          english_cv_outdated = mkDocument {
            folder = "cv_arnaud_english";
            latexFileName = "cv_arnaud_english";
          };
        };
      in {
        # Define output packages
        packages = docs // {
          all_documents = pkgs.symlinkJoin {
            name = "all-documents";
            paths = builtins.attrValues docs;
          };
          default = self.packages.${system}.all_documents;
        };

        # Native formatting runner hook (`nix fmt`)
        formatter = treefmtEval.config.build.wrapper;

        # Adds a syntax formatting validation test automatically on `nix flake check`
        checks = { formatting = treefmtEval.config.build.check self; };

        # Local development environment (`nix develop`)
        devShells.default = pkgs.mkShell {
          buildInputs = [ tex pkgs.biber compile-doc ];
          shellHook = ''
            echo "Build with compile-doc:"
            ${compile-doc}/bin/compile-doc
          '';
        };
      });
}
