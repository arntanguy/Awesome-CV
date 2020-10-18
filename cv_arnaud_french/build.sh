#!/bin/bash
xelatex cv_arnaud_french.tex
biber cv_arnaud_french
xelatex cv_arnaud_french.tex

xelatex coverletter_cnrs.tex
biber coverletter_cnrs
xelatex coverletter_cnrs.tex
