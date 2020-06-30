#!/bin/bash
xelatex cv_arnaud_french.tex
bibex cv_arnaud_french
xelatex cv_arnaud_french.tex

xelatex coverletter_cnrs.tex
bibex coverletter_cnrs
xelatex coverletter_cnrs.tex
