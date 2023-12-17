#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${SCRIPT_DIR}/../
BASE_DIR=$(pwd)
LATEX="pdflatex -src -interaction=nonstopmode"
FOO_LATEX="${LATEX}"

echo "writing file tmp/index.tex"
python2 scripts/make_index.py ${BASE_DIR} > tmp/index.tex 

echo "writing file tmp/book.tex"
python2 scripts/make_book.py ${BASE_DIR} > tmp/book.tex

echo "compiling tmp/index.tex"
${FOO_LATEX} tmp/index.tex > /dev/null

echo "compiling tmp/book.tex"
${FOO_LATEX} tmp/book.tex > /dev/null

echo "bibtex book"
bibtex book > /dev/null

echo "compiling again tmp/book.tex"
${FOO_LATEX} tmp/book.tex > /dev/null
${FOO_LATEX} tmp/book.tex | grep "Output written"