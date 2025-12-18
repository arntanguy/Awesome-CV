#!/bin/bash

# Exit script if any command fails
set -e

# Build CV
xelatex -interaction=nonstopmode -halt-on-error cv_arnaud_french.tex
biber cv_arnaud_french
xelatex -interaction=nonstopmode -halt-on-error cv_arnaud_french.tex

# Build Cover Letter
# xelatex -interaction=nonstopmode -halt-on-error coverletter_cnrs.tex
# biber coverletter_cnrs
# xelatex -interaction=nonstopmode -halt-on-error coverletter_cnrs.tex